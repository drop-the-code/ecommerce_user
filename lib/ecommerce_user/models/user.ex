defmodule EcommerceUser.Models.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset
  alias EcommerceUser.Repo
  alias EcommerceUser.Models.{User, Card}
  import Ecto.Query

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "users" do
    field(:name, :string)
    field(:email, :string)
    field(:password, :string)
    field(:cpf, :string)
    field(:address, :string)
    field(:role, Ecto.Enum, values: [:funcionario, :cliente])
    has_one(:card, Card, on_delete: :delete_all)

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :cpf, :address, :role, :password])
    |> validate_required([:name, :email, :cpf, :address, :role])
    |> put_password_hash()
  end

  defp put_password_hash(
        %Changeset{valid?: true, changes: %{password: password_unhashed}} = changeset
      ) do
    password = Bcrypt.hash_pwd_salt(password_unhashed)
    put_change(changeset, :password, password)
  end

  defp put_password_hash(changeset), do: changeset
end
