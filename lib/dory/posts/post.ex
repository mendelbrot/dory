defmodule Dory.Posts.Post do
  use Dory.Schema
  import Ecto.Changeset
  alias Dory.Forums.Forum
  alias Dory.Accounts.User

  schema "post" do
    belongs_to :forum, Forum
    belongs_to :user, User
    belongs_to :ref, Dory.Posts.Post
    has_many :replies, Dory.Posts.Post
    field :body, :string
    field :post_to_main_feed, :boolean
    timestamps(updated_at: false)
  end

  def create_changeset(post, attrs) do
    post
    |> cast(attrs, [:forum_id, :user_id, :ref_id, :body, :post_to_main_feed])
    |> validate_required([:forum_id, :user_id, :ref_id, :body, :post_to_main_feed])
  end

  def update_changeset(post, attrs) do
    post
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
