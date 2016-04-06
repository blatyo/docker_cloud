defmodule DockerCloud.Regions do
  import DockerCloud
  alias DockerCloud.Page
  alias DockerCloud.Region

  @base_path "api/infra/v1/region/"

  def list(client, params \\ []) do
    get(client, @base_path, params: params, as: Page.sig(Region.sig))
  end

  def region(client, name) do
    get(client, @base_path <> "#{name}/", as: Region.sig)
  end
end
