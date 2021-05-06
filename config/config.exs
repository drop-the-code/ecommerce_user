use Mix.Config

# Start server in OTP
# config :grpc, start_server: true

config :ecommerce_user, ecto_repos: [EcommerceUser.Repo]

import_config "#{Mix.env}.exs"
