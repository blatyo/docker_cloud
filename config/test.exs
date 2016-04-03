use Mix.Config

config :docker_cloud,
  username: System.get_env("DOCKER_CLOUD_USER"),
  token: System.get_env("DOCKER_CLOUD_TOKEN")


config :exvcr, [
  filter_sensitive_data: [
    [pattern: :base64.encode("#{System.get_env("DOCKER_CLOUD_USER")}:#{System.get_env("DOCKER_CLOUD_TOKEN")}"), placeholder: "BASIC_AUTH_PLACEHOLDER"]
  ],
  response_headers_blacklist: ["Set-Cookie"]
]
