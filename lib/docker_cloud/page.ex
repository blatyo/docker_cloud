defmodule DockerCloud.Page do
  alias DockerCloud.Page
  alias Page.Meta

  defstruct meta: %Meta{}, objects: [], next_page: nil

  def sig(type) do
    %Page{objects: [type]}
  end

  def count(page) do
    page.meta.total_count
  end

  def reduce(_, {:halt, acc}, _fun),
    do: {:halted, acc}
  def reduce(page,  {:suspend, acc}, fun),
    do: {:suspended, acc, &reduce(page, &1, fun)}
  def reduce(page, acc, fun),
    do: reduce(page, page.meta, page.objects, acc, fun)

  defp reduce(page, %Meta{next: nil}, [], {:cont, acc}, _fun),
    do: {:done, acc}
  defp reduce(page, _meta, [], acc, fun),
    do: reduce(next_page(page), acc, fun)
  defp reduce(page, meta, [object|rest], {:cont, acc}, fun),
    do: reduce(%{page | objects: rest}, fun.(object, acc), fun)

  def next_page(%Page{next_page: nil}), do: nil
  def next_page(%Page{next_page: next}), do: next.()
end

defimpl Enumerable, for: DockerCloud.Page do
  alias DockerCloud.Page

  def count(%Page{} = page),
    do: {:ok, Page.count(page)}

  def member?(%Page{} = page, _value),
    do: {:error, __MODULE__}

  def reduce(%Page{} = page, acc, fun),
    do: Page.reduce(page, acc, fun)
end
