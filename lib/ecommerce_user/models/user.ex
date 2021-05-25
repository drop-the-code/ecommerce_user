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
    |> validate_format(:email,~r/@/)
    |> unique_constraint(:unique_email , name: :unique_email , message: "email already in use")
    |> put_password_hash()
  end

  defp put_password_hash(
        %Changeset{valid?: true, changes: %{password: password_unhashed}} = changeset
      ) do
    password = Bcrypt.hash_pwd_salt(password_unhashed)
    put_change(changeset, :password, password)
  end

  defp put_password_hash(changeset), do: changeset

  def changeset_error_to_string(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
    |> Enum.reduce("", fn {k, v}, acc ->
      joined_errors = Enum.join(v, "; ")
      "#{acc}#{k}: #{joined_errors}\n"
    end)
  end

  def compare_password(hashpass, pass) do
     Bcrypt.verify_pass(pass,hashpass)
  end

end
