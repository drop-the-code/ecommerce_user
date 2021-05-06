defmodule EcommerceUser do

    use Application

    def start(_type, _args) do
      import Supervisor.Spec

      children = [
        supervisor(GRPC.Server.Supervisor, [{EcommerceUser.Endpoint, 50051}])
      ]

      opts = [strategy: :one_for_one, name: EcommerceUser]
      Supervisor.start_link(children, opts)
    end
  end
