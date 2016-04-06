defmodule DockerCloud.ActionsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest DockerCloud.Actions

  setup_all do
    HTTPoison.start
  end

  setup do
    {:ok, [
      client: DockerCloud.client(Application.get_env(:docker_cloud, :username), Application.get_env(:docker_cloud, :token))
    ]}
  end

  test ".list returns the first page, which can get the next page", context do
    use_cassette "actions#list/success", match_requests_on: [:query] do
      result = context[:client] |> DockerCloud.Actions.list(limit: 2)

      assert match?({:ok, %DockerCloud.Page{}}, result)
      {:ok, %DockerCloud.Page{meta: meta, objects: actions, next_page: next}} = result

      assert meta.limit == 2
      assert meta.offset == 0
      assert actions |> Enum.all?(fn(action) -> match?(%DockerCloud.Action{}, action) end)

      assert next |> is_function
      next_page_result = next.()

      assert match?({:ok, %DockerCloud.Page{}}, next_page_result)
      {:ok, %DockerCloud.Page{meta: next_meta}} = next_page_result

      assert next_meta.limit == 2
      assert next_meta.offset == 2
    end
  end

  test ".action returns an action", context do
    use_cassette "actions#action/success" do
      result = context[:client] |> DockerCloud.Actions.action("7859a8f9-5f03-4f25-8f60-0fd7d16d3e09")

      assert match?({:ok, %DockerCloud.Action{}}, result)
    end
  end
end
