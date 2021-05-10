defmodule EcommerceUser.Repo.Migrations.Users do
  use Ecto.Migration


  def change do
    create table("users") do
      add :name, :string
      add :email, :string
      add :password, :string
      add :cpf , :string
      add :address , :string
      add :role , :string
      add :card , :string
      timestamps()
    end
  end
end

# string name = 1;
# string email = 2;
# string password = 3;
# string cpf = 4;
# string endereco = 5;
# string cartao = 6;
# Role role = 7;
