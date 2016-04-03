defmodule DockerCloud do
  use HTTPoison.Base
  alias DockerCloud.Client
  alias DockerCloud.Error
  alias HTTPoison.Response
  alias DockerCloud.Page
  alias Page.Meta
  require IEx

  @endpoint "https://cloud.docker.com/"

  def client(username, token) do
    %Client{username: username, token: token}
  end

  def get(%Client{} = client, path, options) do
    page = request(:get, path, "", headers(client), options)
      |> decode_response(options[:as])
    #IEx.pry
    setup_next_page(page, client, path, options)
  end

  def post(%Client{} = client, path, body \\ "", options) do
    request(:post, path, body, headers(client), options)
      |> decode_response(options[:as])
  end

  def put(%Client{} = client, path, body \\ "", options) do
    request(:put, path, body, headers(client), options)
      |> decode_response(options[:as])
  end

  def patch(%Client{} = client, path, body \\ "", options) do
    request(:patch, path, body, headers(client), options)
      |> decode_response(options[:as])
  end

  def delete(%Client{} = client, path, options) do
    request(:delete, path, "", headers(client), options)
      |> decode_response(options[:as])
  end

  defp headers(client) do
    [{"Authorization", "Basic #{Client.auth(client)}"}, {"Accept", "application/json"}]
  end

  defp process_url(path) do
    @endpoint <> path
  end

  defp process_request_body(%{} = body), do: Poison.encode!(body)
  defp process_request_body(body), do: body

  defp decode_response({:ok, response}, as) do
    case response do
      %Response{status_code: code} when code in 400..499 ->
        {:error, decode_error(response.body, code)}
      %Response{status_code: code} when code in 200..299 ->
        {:ok, decode_type(response.body, as)}
    end
  end
  defp decode_response({:error, _} = response),
    do: response

  defp decode_error(body, code),
    do: %{decode_type(body, %Error{}) | code: code}
  defp decode_type(body, as),
    do: Poison.decode!(body, as: as)

  defp setup_next_page({:ok, %Page{} = page}, client, path, options) do
    params = Keyword.merge(options[:params], offset: Meta.next_offset(page.meta))
    options = Keyword.merge(options, params: params)

    {:ok, %{page | next_page: fn -> get(client, path, options) end}}
  end
  defp setup_next_page(item, _, _, _), do: item
end
