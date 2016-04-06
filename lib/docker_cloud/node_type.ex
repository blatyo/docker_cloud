defmodule DockerCloud.NodeType do
  defstruct availability_zones: [],
            available: false,
            label: nil,
            name: nil,
            regions: [],
            provider: nil,
            resource_uri: nil

  def sig do
    %DockerCloud.NodeType{}
  end
end
