defmodule DockerCloud.Actions do
  import DockerCloud
  alias DockerCloud.Page
  alias DockerCloud.Action

  @base_path "api/audit/v1/action/"

  def list(client, params \\ []) do
    get(client, @base_path, params: params, as: Page.sig(Action.sig))
  end

  def action(client, uuid) do
    get(client, @base_path <> "#{uuid}/", as: Action.sig)
  end

  def cancel(client, uuid) do
    post(client, @base_path <> "#{uuid}/cancel/")
  end

  def retry(client, uuid) do
    post(client, @base_path <> "#{uuid}/retry/")
  end
end
