
defmodule Helloworld.Greeter.Server do
  use GRPC.Server, service: User.User.Service


  def say_hello(request, _stream) do
    User.UserReply.new(name: request.name , email: request.email)
  end
end
