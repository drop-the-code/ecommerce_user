defmodule EcommerceUser.Repo.Migrations.InsertUserAdmin do
  use Ecto.Migration

  def change do
    execute("INSERT INTO users(id,name,email,password,role,address,cpf,inserted_at,updated_at) VALUES('ad352463-d6a1-4da8-9056-d97ca071e065','admin','admin@admin.com' ,'$2b$12$u4rNBGZywWZ40E/t4xL6gedV085ezFJjF9Z1FDh8GN.LbS6.LJNLC','funcionario' ,'Rio Grande' , '12342', '2021-06-11T06:52:06.255Z','2021-06-11T06:52:06.255Z') " ,
    "DELETE FROM users WHERE email='admin@admin.com' ")
  end
end
