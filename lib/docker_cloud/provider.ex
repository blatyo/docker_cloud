defmodule DockerCloud.Provider do
  defstruct available: false, label: nil, name: nil, regions: [], resource_uri: nil

  def sig do
    %DockerCloud.Provider{}
  end
end
