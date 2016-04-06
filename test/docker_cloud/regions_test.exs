defmodule DockerCloud.RegionsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest DockerCloud.Regions

  setup_all do
    HTTPoison.start
  end

  setup do
    {:ok, [
      client: DockerCloud.client(Application.get_env(:docker_cloud, :username), Application.get_env(:docker_cloud, :token))
    ]}
  end

  test ".list returns the first page", context do
    use_cassette "regions#list/success" do
      result = context[:client] |> DockerCloud.Regions.list(limit: 2)

      assert {:ok, %DockerCloud.Page{}} = result
    end
  end

  test ".region returns a region", context do
    use_cassette "regions#region/success" do
      result = context[:client] |> DockerCloud.Regions.region("digitalocean")

      assert {:ok, %DockerCloud.Region{}} = result
    end
  end
end
