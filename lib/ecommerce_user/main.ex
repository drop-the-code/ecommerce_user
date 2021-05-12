defmodule EcommerceUser.Main do

    use Application

    def start(_type, _args) do
      port =  Application.get_env(:ecommerce_user,:port_grpc_server) |> String.to_integer()
      IO.puts("GRPC running in port #{port}")
      import Supervisor.Spec
      children = [
        {EcommerceUser.Repo, []},
        supervisor(GRPC.Server.Supervisor, [{EcommerceUser.Endpoint, port}])
      ]

      opts = [strategy: :one_for_one, name: EcommerceUser.Main , name: EcommerceUser.Repo]
      Supervisor.start_link(children, opts)
    end
  end
