
defmodule EcommerceUser.User.Server do
  use GRPC.Server, service: EcommerceUser.UserService.Service
  alias EcommerceUser.Models.User

  def create(request, _stream) do
    params =   %{
      card: request.user.cartao,
      cpf: request.user.cpf,
      email: request.user.email,
      address: request.user.endereco,
      name: request.user.name,
      password: request.user.password,
      role: request.user.role
    }

    with {:ok, %User{} = user} <- User.create_user(params) do
      EcommerceUser.User.new(
        %{
          id: user.id,
          card: user.cartao,
          name: user.name ,
          email:  user.email ,
          cpf:  user.cpf,
          address: user.endereco,
          role:  user.role
        }
      )

    end



  end

  def update(request,_stream) do
    IO.inspect(request)
    params =   %{
      card: request.user.cartao,
      cpf: request.user.cpf,
      email: request.user.email,
      address: request.user.endereco,
      name: request.user.name,
      password: request.user.password,
      role: request.user.role
    }
    user = User.get_user!(request.user.id)
    with {:ok, %User{} = user} <- User.update_user(user,params) do
      EcommerceUser.User.new(
        %{
          id: user.id,
          card: user.cartao,
          name: user.name ,
          email:  user.email ,
          cpf:  user.cpf,
          address: user.endereco,
          role:  user.role
        })

    end
  end

  def delete(request,_stream) do
    IO.inspect(request)
    with {:ok, %User{} = user} <- User.delete_user(request.user.id) do
      EcommerceUser.User.new(
        %{
          id: user.id,
          card: user.cartao,
          name: user.name ,
          email:  user.email ,
          cpf:  user.cpf,
          address: user.endereco,
          role:  user.role
        })
        end
  end

  def selectall(_request,_stream) do
    allusers = User.list_all()
    IO.inspect(allusers)
    EcommerceUser.UserList.new(
      users: allusers
    )

  end

  def selectByName(_request,_stream) do

  end
  def selectByID(_request,_stream) do

  end


end
