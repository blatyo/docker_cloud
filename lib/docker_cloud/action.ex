defmodule DockerCloud.Action do
  defstruct [:action,
             :body,
             :end_date,
             :ip,
             :is_user_action,
             :can_be_cancelled,
             :location,
             :method,
             :object,
             :path,
             :resource_uri,
             :start_date,
             :state,
             :user_agent,
             :uuid]

  def sig do
    %DockerCloud.Action{}
  end
end

defimpl Poison.Decoder, for: DockerCloud.Action do
  def decode(%DockerCloud.Action{} = action, _options) do
    %{action |
        start_date: elem(Timex.parse(action.start_date, "{RFC1123}"), 1),
        end_date: elem(Timex.parse(action.end_date, "{RFC1123}"), 1)}
  end
end
