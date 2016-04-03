defmodule DockerCloud.ClientTest do
  use ExUnit.Case, async: true
  alias DockerCloud.Client
  doctest DockerCloud.Client

  test ".auth generates basic auth" do
    client = %Client{username: "bob", token: "token"}
    assert Client.auth(client) == "Ym9iOnRva2Vu"
  end
end
