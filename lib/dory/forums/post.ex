defmodule Dory.Forums.Post do
  use Dory.Schema
  import Ecto.Changeset
  alias Dory.Forums.{Forum, Thread}
  alias Dory.Accounts.User

  schema "posts" do
    belongs_to(:forum, Forum)
    belongs_to(:thread, Thread)
    belongs_to(:user, User)
    belongs_to(:ref, Dory.Forums.Post)
    has_many(:replies, Dory.Forums.Post, foreign_key: :ref_id)
    field(:body, :string)
    field(:post_to_main_feed, :boolean)
    timestamps()
  end

  @doc """
  - If the post id being added to a thread, just create the post.
  - If the post is starting a new thread, then create the thread and add the post as an association.
  """
  def create_changeset(post, attrs) do
    thread_id = Map.get(attrs, :thread_id)

    post =
      post
      |> cast(attrs, [:forum_id, :user_id, :thread_id, :ref_id, :body, :post_to_main_feed])
      |> validate_required([:forum_id, :user_id, :body, :post_to_main_feed])

    case thread_id do
      nil ->
        %Thread{}
        |> cast(attrs, [:forum_id])
        |> validate_required([:forum_id])
        |> put_assoc(:posts, [post])

      _ ->
        post
    end
  end

  def update_changeset(post, attrs) do
    post
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
