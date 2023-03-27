defmodule Dory.Forums.PostVM do
  use Dory.Schema
  alias Dory.Forums.{Forum, Thread}
  alias Dory.Accounts.User

  schema "posts_vm" do
    belongs_to(:forum, Forum)
    belongs_to(:thread, Thread)
    belongs_to(:user, User)
    belongs_to(:ref, Dory.Forums.Post)
    has_many(:replies, Dory.Forums.Post, foreign_key: :ref_id)
    field(:body, :string)
    field(:post_to_main_feed, :boolean)
    field(:username, :string)
    timestamps()
  end
end
