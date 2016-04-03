defmodule DockerCloudTest do
  use ExUnit.Case, async: true
  doctest DockerCloud

  test ".client returns configured client" do
    assert DockerCloud.client("bob", "token") == %DockerCloud.Client{username: "bob", token: "token"}
  end
end
