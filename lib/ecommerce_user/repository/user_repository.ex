defmodule EcommerceUser.Repository.User do
  import Ecto.Query
  alias EcommerceUser.Models.{User, Card}
  alias EcommerceUser.Repo
  alias EcommerceUser.Repository.Card , as: CardRepository

  def list_all() do
      user_join_card = from( user in User, left_join: card in Card , on: card.user_id == user.id)
        query = from( [user,card] in user_join_card , select: %{
          id: user.id,
          name: user.name,
          address: user.address,
          role: user.role,
          cpf: user.cpf,
          email: user.email,
          password: user.password,
          card: %{
            id: card.id,
            name: card.name,
            validThru: card.validThru,
            securityCode:  card.securityCode,
            number: card.number
          }
        })
    Repo.all(query)
  end

  def create_user_with_card(attrs \\ %{}) do
    userParams = Map.delete(attrs,:card)
    try do
    Repo.transaction(fn  ->

      user = %User{}
      |> User.changeset(userParams)
      |> Repo.insert!(returning: [:name ,:address,:email,:cpf,:password,:role])
      if ! Map.equal?(attrs.card , %{ name: "", number: "" , securityCode: "", validThru: "" }) do
        %Card{}
        |> Card.changeset(attrs.card |> Map.put(:user_id , user.id))
        |> Repo.insert!()
      end
      user |> Repo.preload(:card)

    end)
  rescue
    raise_error -> {:error,raise_error}
  end
end


  def update_user(attrs) do
    userParams = Map.delete(attrs,:card)
    try do
    Repo.transaction(fn ->
      user = get_user_id!(userParams.id)
      |> User.changeset(userParams)
      |> Repo.update!()
      if ! Map.equal?(attrs.card , %{ id: "" , name: "", number: "" , securityCode: "", validThru: "" }) do

      CardRepository.get_card_from_user_id!(user.id)
      |> Card.changeset(attrs.card)
      |> Repo.update!()
      end
      user |> Repo.preload(:card, force: true)

    end)
    rescue
      raise_error -> {:error,raise_error}
    end
  end

  def delete_user(id) do
    try do
      get_user_id!(id)
      |> Repo.delete()
      rescue
        raise_error -> {:error,raise_error}
    end
  end

  def get_user_id!(id) do
    try do
      Repo.get!(User, id) |> Repo.preload(:card)
    rescue
      raise_error -> {:error,raise_error}
    end
  end

  def get_user_email!(email,password)  do
    query = from user in User, left_join: card in Card , on: card.user_id == user.id, where: user.email == ^email , select: %{
      id: user.id,
      name: user.name,
      address: user.address,
      role: user.role,
      cpf: user.cpf,
      email: user.email,
      password: user.password,
      card: %{
        id: card.id,
        name: card.name,
        validThru: card.validThru,
        securityCode:  card.securityCode,
        number: card.number
      }
    }
    user = Repo.one(query)
    IO.inspect User.compare_password(user.password,password)
    if User.compare_password(user.password,password) , do: user, else: nil
  end
end
