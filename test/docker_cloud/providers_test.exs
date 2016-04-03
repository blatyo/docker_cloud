defmodule DockerCloud.ProvidersTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest DockerCloud.Providers

  setup_all do
    HTTPoison.start
  end

  setup do
    {:ok, [
      client: DockerCloud.client(Application.get_env(:docker_cloud, :username), Application.get_env(:docker_cloud, :token))
    ]}
  end

  test ".list returns the first page", context do
    use_cassette "providers#list/success" do
      result = context[:client] |> DockerCloud.Providers.list(limit: 2)

      assert {:ok, %DockerCloud.Page{}} = result
    end
  end

  test ".provider returns a provider", context do
    use_cassette "providers#provider/success" do
      result = context[:client] |> DockerCloud.Providers.provider("digitalocean")

      assert {:ok, %DockerCloud.Provider{}} = result
    end
  end
end
