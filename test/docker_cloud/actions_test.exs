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

  test ".list returns the first page", context do
    use_cassette "actions#list/success" do
      result = context[:client] |> DockerCloud.Actions.list(limit: 2)

      assert {:ok, %DockerCloud.Page{}} = result
    end
  end

  test ".action returns an action", context do
    use_cassette "actions#action/success" do
      result = context[:client] |> DockerCloud.Actions.action("7859a8f9-5f03-4f25-8f60-0fd7d16d3e09")

      assert {:ok, %DockerCloud.Action{}} = result
    end
  end
end
