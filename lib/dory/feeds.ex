defmodule Dory.Feeds do
  import Ecto.Query, warn: false
  alias Dory.Repo
  alias Dory.Forums.Thread

  def forum_live_view_data(forum_id) do
    query =
      from(t in Thread,
        where: t.forum_id == ^forum_id,
        preload: [:posts_vm],
        select: t,
        order_by: [asc: t.inserted_at]
      )

    Repo.all(query)
  end
end
