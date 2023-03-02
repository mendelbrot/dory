# experimenting with ecto associations

alias Dory.Accounts.{User, Profile}
alias Dory.Repo
user = %User{id: 1}
profile = Ecto.build_assoc(user, :profile, %{username: "Cylon Pylon"})
Repo.insert!(profile)

import Dory.Accounts
register_user(%{email: "greg@home.com", password: "12characters"})
create_profile(%{user_id: 1, username: "Cylon Pylon"})
update_profile(%Profile{id: 1}, %{id: 1, username: "Cylon Smile On"})
