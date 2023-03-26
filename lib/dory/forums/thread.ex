defmodule Dory.Forums.Thread do
  use Dory.Schema
  import Ecto.Changeset
  alias Dory.Forums.{Forum, Post}

  schema "threads" do
    belongs_to :forum, Forum
    has_many :posts, Post
    timestamps(updated_at: false)
  end

  def create_changeset(thread, attrs, posts \\ []) do
    thread
    |> cast(attrs, [:forum_id])
    |> validate_required([:forum_id])
    |> put_assoc(:posts, posts)
  end
end
