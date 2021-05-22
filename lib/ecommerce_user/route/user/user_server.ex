
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

    with { :ok, %User{} = user} <- UserRepository.create_user(params) do
      EcommerceUser.User.new(
        %{
          id: user.id,
          card: EcommerceUser.Card.new(%{
              id: user.card.id,
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
    params =   %{
      id: request.user.id,
      card: %{
        id: request.user.card.id,
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
    with {:ok, %User{} = user} <- UserRepository.update_user(params) do
      IO.inspect(user)
      EcommerceUser.User.new(
        %{
          id: user.id,
          card: EcommerceUser.Card.new(%{
            id: user.card.id,
            name: user.card.name ,
            securityCode: user.card.securityCode ,
            number: user.card.number,
            validThru: user.card.validThru
        }),
          name: user.name ,
          email:  user.email ,
          cpf:  user.cpf,
          address: user.address,
          role:  user.role,
          password: user.password
        })
          else
            {:error, %Ecto.InvalidChangesetError{} = invalidChangeset} ->
              message = User.changeset_error_to_string(invalidChangeset.changeset)
              raise GRPC.RPCError, status: GRPC.Status.invalid_argument() , message: message

    end

  end

  def delete(request,_stream) do
    IO.inspect(request)
    with {:ok, %User{} = user} <- UserRepository.delete_user(request.id) do
      EcommerceUser.User.new(
        %{
        id: user.id,
        card: EcommerceUser.Card.new(%{
            id: user.card.id,
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
      })
        else
          {:error , _} -> raise GRPC.RPCError, status: GRPC.Status.not_found() , message: "user not found"
        end
  end

  def select_all(_request,_stream) do
    allusers = UserRepository.list_all()
    IO.inspect(allusers)
    EcommerceUser.UserList.new(
      users: allusers
    )


  end

  def select_by_id(request,_stream) do
    with %User{} = user <- UserRepository.get_user_id!(request.id) do
    EcommerceUser.User.new(
      %{
        id: user.id,
        card: EcommerceUser.Card.new(%{
            id: user.card.id,
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
      })
    else
      {:error , _ } -> raise GRPC.RPCError, status: GRPC.Status.not_found() , message: "user not found"
    end

  end


end
