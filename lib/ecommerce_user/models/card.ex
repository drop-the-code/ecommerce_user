defmodule EcommerceUser.Models.Card do
  use Ecto.Schema
  import Ecto.Changeset
  alias EcommerceUser.Models.User
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "cards" do
    field(:name, :string)
    field(:securityCode, :string)
    field(:validThru, :string)
    field(:number, :string)
    belongs_to(:user, User)
    timestamps()
  end

  def changeset(card, attrs) do
    card
    |> cast(attrs, [:name, :securityCode, :validThru, :number,:user_id])
    |> validate_required([:name, :securityCode, :validThru, :number,:user_id])
  end
end
