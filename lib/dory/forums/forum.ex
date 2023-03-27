defmodule Dory.Forums.Forum do
  use Dory.Schema
  import Ecto.Changeset
  alias Dory.Forums.{Post, PostVM, ForumUser}
  alias Dory.Accounts.User

  schema "forums" do
    field :name, :string
    many_to_many :users, User, join_through: "forum_users"
    has_many :forum_users, ForumUser
    has_many :posts, Post
    has_many :posts_vm, PostVM
    timestamps(updated_at: false)
  end

  def create_changeset(forum, attrs, forum_users \\ []) do
    forum
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> put_assoc(:forum_users, forum_users)
    |> unique_constraint(:name)
  end

  def update_changeset(forum, attrs) do
    forum
    |> cast(attrs, [:name])
    |> unique_constraint(:name)
  end
end
