defmodule Dory.Forums.Forum do
  use Dory.Schema
  import Ecto.Changeset
  alias Dory.Forums.ForumUser
  alias Dory.Accounts.User
  alias Dory.Posts.Post

  schema "forums" do
    field :name, :string
    many_to_many :users, User, join_through: "forum_users"
    has_many :forum_users, ForumUser
    has_many :posts, Post
    timestamps(updated_at: false)
  end

  def create_changeset(forum, attrs, forum_users) do
    forum
    |> cast(attrs, [:name])
    |> put_assoc(:forum_users, forum_users)
    |> validate_required([:name])
    |> unique_constraint(:name)
  end

  def update_changeset(forum, attrs) do
    forum
    |> cast(attrs, [:name])
    |> unique_constraint(:name)
  end
end
