defmodule Dory.Threads do
  import Ecto.Query, warn: false
  alias Dory.Repo
  alias Dory.Forums.{Forum, Post}

  def create(attrs, posts \\ []) do
    %Forum{}
    |> Forum.create_changeset(attrs, posts)
    |> Repo.insert()
  end

  def get_threads_in_forum(forum_id) do
    query =
      from t in Thread,
        where: t.id == ^thread_id,
        preload: [:posts],
        select: t

    Repo.all(query)
  end

  def get(id) do
    Repo.get(Thread, id)
  end

  def delete(id) do
    thread = Repo.get(Thread, id)
    Repo.delete(thread)
  end
end
