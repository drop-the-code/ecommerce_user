use Mix.Config
config :grpc, start_server: true

config :logger,
  level: :warn

config :ecommerce_user,
port_grpc_server:  System.get_env("GRPC_PORT")

config :ecommerce_user, EcommerceUser.Repo,
username: System.get_env("DB_USER"),
password: System.get_env("DB_PASSWORD"),
database: System.get_env("DB_NAME"),
hostname: System.get_env("DB_HOST"),
port: 5432,
show_sensitive_data_on_connection_error: true,
pool_size: 10
