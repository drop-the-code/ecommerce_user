defmodule EcommerceUser.Repo.Migrations.Users do
  use Ecto.Migration

  def change do
    create table('users') do
      add :name, :string,
      add :email, :string,
    end
  end
end
