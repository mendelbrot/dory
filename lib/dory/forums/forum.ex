defmodule Dory.Forums.Forum do
  use Dory.Schema
  import Ecto.Changeset
  alias Dory.Forums.ForumUsers
  alias Dory.Accounts.User

  schema "forums" do
    field :name, :string
    many_to_many :users, User, join_through: "forum_users"
    has_many :forum_users, ForumUsers
    timestamps()
  end

  def create_changeset(attrs, forum_users) do
    %Forum{}
    |> cast(attrs, [:name])
    |> put_assoc(:forum_users, forum_users)
    |> validate_required([:name])
    |> unique_constraint(:name)
  end

  def update_changeset(%Forum{} = forum, attrs) do
    forum
    |> cast(attrs, [:name])
    |> unique_constraint(:name)
  end
end
