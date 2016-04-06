defmodule DockerCloud.Region do
  defstruct availability_zones: [],
            available: false,
            label: nil,
            name: nil,
            node_types: [],
            provider: nil,
            resource_uri: nil

  def sig do
    %DockerCloud.Region{}
  end
end
