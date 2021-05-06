defmodule EcommerceUser.Main do

    use Application

    def start(_type, _args) do
      IO.puts("GRPC running in port 50051")
      import Supervisor.Spec

        children = [
          {EcommerceUser.Repo,[]},
          supervisor(GRPC.Server.Supervisor, [{EcommerceUser.Endpoint, 50051}])
        ]

      opts = [strategy: :one_for_one, name: EcommerceUser.Main , name: EcommerceUser.Repo]
      Supervisor.start_link(children, opts)
    end
  end
