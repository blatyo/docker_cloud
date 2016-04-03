defmodule DockerCloud.Providers do
  import DockerCloud
  alias DockerCloud.Page
  alias DockerCloud.Provider

  @base_path "api/infra/v1/provider/"

  def list(client, params \\ []) do
    get(client, @base_path, params: params, as: Page.sig(Provider.sig))
  end

  def provider(client, name) do
    get(client, @base_path <> "#{name}/", as: Provider.sig)
  end
end
