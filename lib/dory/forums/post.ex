defmodule Dory.Forums.Post do
  use Dory.Schema
  import Ecto.Changeset
  alias Dory.Forums.{Forum, Thread}
  alias Dory.Accounts.User

  schema "post" do
    belongs_to :forum, Forum
    belongs_to :thread, Thread
    belongs_to :user, User
    belongs_to :ref, Dory.Posts.Post
    has_many :replies, Dory.Posts.Post
    field :body, :string
    field :post_to_main_feed, :boolean
    timestamps(updated_at: false)
  end

  def maybe_create_thread(changeset) do
    thread_id = get_change(changeset, :thread_id)

    case thread_id do
      nil ->
        changeset

      _ ->
        forum_id = get_change(changeset, :thread_id)
        thread = %Thread{forum_id: forum_id}
        put_assoc(changeset, :thread, thread)
    end
  end

  def create_changeset(post, attrs) do
    post
    |> cast(attrs, [:forum_id, :user_id, :thread_id, :ref_id, :body, :post_to_main_feed])
    |> validate_required([:forum_id, :user_id, :ref_id, :body, :post_to_main_feed])
    |> maybe_create_thread
  end

  def update_changeset(post, attrs) do
    post
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
