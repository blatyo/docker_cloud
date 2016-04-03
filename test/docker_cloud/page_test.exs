defmodule DockerCloud.PageTest do
  use ExUnit.Case, async: true
  alias DockerCloud.Page
  alias DockerCloud.Page.Meta
  doctest DockerCloud.Page

  setup do
    page = %Page{
      meta: %Meta{
        limit: 2,
        next: "next/2",
        offset: 0,
        previous: nil,
        total_count: 3
      },
      objects: [1, 2],
      next_page: fn ->
        %Page{
          meta: %Meta{
            limit: 2,
            next: nil,
            offset: 0,
            previous: "previous/0",
            total_count: 3
          },
          objects: [3]
        }
      end
    }

    {:ok, page: page}
  end

  test "Implements enumerable count as returning total items being paged", context do
    assert Enum.count(context[:page]) == 3
  end

  test "Implements enumerable reduce returning all items from all pages", context do
    assert Enum.to_list(context[:page]) == [1, 2, 3]
  end
end
