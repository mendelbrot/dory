defmodule Dory.Forums.ForumUser do
  use Dory.Schema
  import Ecto.Changeset, warn: false
  alias Dory.Forums.Forum
  alias Dory.Accounts.User

  schema "forum_users" do
    belongs_to :user, User
    belongs_to :forum, Forum
    timestamps(updated_at: false)
  end

  def create_changeset(forum_user, attrs) do
    forum_user
    |> cast(attrs, [:forum_id, :user_id])
    |> validate_required([:forum_id, :user_id])
    |> unique_constraint([:forum_id, :user_id])
  end
end
