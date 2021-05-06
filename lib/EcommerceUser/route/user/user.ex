
defmodule EcommerceUser.User.Server do
  use GRPC.Server, service: EcommerceUser.User.Service


  def create(request, _stream) do
    EcommerceUser.UserResponse.new(name: request.name , email: request.email)
  end

  def update(request,_stream) do
    IO.inspect(request)
  end

  def delete(request,_stream) do
    IO.inspect(request)

  end

  def selectAll(request,_stream) do
    IO.inspect(request)

  end

  def selectByName(request,_stream) do
    IO.inspect(request)

  end


end
