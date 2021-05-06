
{:ok, channel} = GRPC.Stub.connect("localhost:50051", interceptors: [GRPC.Logger.Client])

{:ok, reply} =
  channel |> User.User.Stub.say_hello(User.UserRequest.new(name: "Vinicius" , email: "vinnyaoe@gmail.com"))

IO.inspect(reply)
