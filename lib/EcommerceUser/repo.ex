defmodule EcommerceUser.Repo do
  use Ecto.Repo,
    otp_app: :ecommerce_user,
    adapter: Ecto.Adapters.Postgres

end
