
defmodule EcommerceUser.User.Server do
  use GRPC.Server, service: EcommerceUser.UserService.Service
  alias EcommerceUser.Repository.User , as: UserRepository
  alias EcommerceUser.Models.User

  def create(request, _stream) do
    # raise GRPC.RPCError, status: :permission_denied
    params =   %{
      card: %{
        name: request.user.card.name ,
        securityCode: request.user.card.securityCode,
        validThru: request.user.card.validThru,
        number: request.user.card.number
      },
      cpf: request.user.cpf,
      email: request.user.email,
      address: request.user.address,
      name: request.user.name,
      password: request.user.password,
      role: request.user.role
    }
    IO.inspect request.user.card

    with {:ok, %User{} = user} <- UserRepository.create_user(params) do
      EcommerceUser.User.new(
        %{
          id: user.id,
          card: EcommerceUser.Card.new(%{
              name: user.card.name ,
              securityCode: user.card.securityCode ,
              number: user.card.number,
              validThru: user.card.validThru
          }),
          name: user.name ,
          email:  user.email ,
          cpf:  user.cpf,
          address: user.address,
          role:  user.role
        }
      )
      else
        {:error, %Ecto.InvalidChangesetError{} = invalidChangeset} ->
          message = User.changeset_error_to_string(invalidChangeset.changeset)
          IO.inspect "CAIU AQUI NESSA MERDA"
          IO.inspect message
          raise GRPC.RPCError, status: :invalid_argument, message: message
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
    # allusers = User.list_all()
    # IO.inspect(allusers)
    # EcommerceUser.UserList.new(
    #   users: allusers
    # )
    EcommerceUser.User.Error.new(
      code: EcommerceUser.Error
    )

  end

  def selectByName(_request,_stream) do

  end
  def selectByID(_request,_stream) do

  end


end
