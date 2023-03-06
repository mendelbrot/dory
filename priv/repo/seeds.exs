# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Dory.Repo.insert!(%Dory.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Dory.Accounts
alias Dory.Forums

{:ok, user} = Accounts.register_user(%{email: "a@a.com", password: "00000000"})
IO.inspect(user)

{:ok, profile} =
  Accounts.create_profile(%{
    user_id: user.id,
    username: "A",
    icon: "https://cdn-icons-png.flaticon.com/128/3069/3069186.png"
  })

IO.inspect(profile)

{:ok, forum} = Forums.create(%{name: "Home"}, [user.id])
IO.inspect(forum)
