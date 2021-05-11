use Mix.Config
config :grpc, start_server: true

config :logger,
  level: :warn


config :ecommerce_user, EcommerceUser.Repo,
database: "ecommerce_user_dev",
username: "root",
password: "root",
hostname: "localhost",
port: "5432",
show_sensitive_data_on_connection_error: true,
pool_size: 10
