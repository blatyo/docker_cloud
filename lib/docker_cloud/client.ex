defmodule DockerCloud.Client do
  defstruct username: nil, token: nil

  def auth(client) do
    :base64.encode("#{client.username}:#{client.token}")
  end
end
