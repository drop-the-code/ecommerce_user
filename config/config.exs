use Mix.Config

# Start server in OTP
# config :grpc, start_server: true

config :ecommerce_user, ecto_repos: [EcommerceUser.Repo]

config :ecommerce_user , EcommerceUser.Repo ,
migration_primary_key: [type: :binary_id],
migration_foreign_key: [type: :binary_id]



import_config "#{Mix.env}.exs"
