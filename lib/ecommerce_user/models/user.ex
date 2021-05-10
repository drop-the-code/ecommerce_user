defmodule EcommerceUser.Models.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias EcommerceUser.Repo
  alias EcommerceUser.Models.User
  import Ecto.Query
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string
    field :cpf , :string
    field :address , :string
    field :role , Ecto.Enum, values: [:funcionario,:cliente]
    field :card , :string

    timestamps()
  end

  def changeset(user , attrs) do
    user
    |> cast(attrs , [:name,:email,:password,:cpf,:address,:role,:card])
    |> validate_required( [:name,:email,:cpf,:endereco,:role])
  end


  def list_all() do
    query = from(u in User,select: %{
                      name: u.name,
                      email: u.email,
                      cpf: u.cpf ,
                      cartao: u.cartao,
                      endereco: u.endereco,
                      role: u.role
                      })
    Repo.all(query)
  end


  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert(returning: true)
  end

  def  update_user(%User{} = user ,attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()

  end
  def delete_user(id) do
    get_user!(id)
    |> Repo.delete()
  end

  def get_user!(id) do
    Repo.get!(User,id)
  end

end
