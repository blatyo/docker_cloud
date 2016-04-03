defmodule DockerCloud.Page.Meta do
  defstruct limit: nil,
            next: nil,
            offset: 0,
            previous: nil,
            total_count: nil

  def next_offset(meta) do
    meta.offset + meta.limit
  end
end
