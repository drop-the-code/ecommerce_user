defmodule EcommerceUser.Repository.Card do
  alias EcommerceUser.Models.{Card,User}
  alias EcommerceUser.Repo
  import Ecto.Query

def get_card_from_user_id!(user_id) do
    user_join_card = from( card in Card, join: user in User , on: user.id == card.user_id)
    query = from( [card,_user] in user_join_card , where: card.user_id == ^user_id)
    Repo.one!(query)
end

end
