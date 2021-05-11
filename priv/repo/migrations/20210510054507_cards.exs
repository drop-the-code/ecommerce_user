defmodule EcommerceUser.Repo.Migrations.Cards do
  use Ecto.Migration

  def change do
    create table("cards") do
      add :name, :string
      add :securityCode, :string
      add :number , :string
      add :validThru , :string
      add :user_id , references(:users)
      # add :user_card , :integer
      timestamps()
    end
  end
end
