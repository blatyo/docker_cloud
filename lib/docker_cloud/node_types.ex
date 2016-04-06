defmodule DockerCloud.NodeTypes do
  import DockerCloud
  alias DockerCloud.Page
  alias DockerCloud.NodeType

  @base_path "api/infra/v1/nodetype/"

  def list(client, params \\ []) do
    get(client, @base_path, params: params, as: Page.sig(NodeType.sig))
  end

  def node_type(client, provider_name, name) do
    get(client, @base_path <> "#{provider_name}/#{name}/", as: NodeType.sig)
  end
end
