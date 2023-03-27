defmodule Dory.Posts do
  import Ecto.Query, warn: false
  alias Dory.Repo
  alias Dory.Forums.Post

  @topic "posts"

  defp notify_subscribers({:ok, result}, event) do
    Phoenix.PubSub.broadcast(
      Dory.PubSub,
      @topic <> ":#{result.forum_id}",
      {event, result.id}
    )

    {:ok, result}
  end

  defp notify_subscribers({:error, reason}, _), do: {:error, reason}

  def create(attrs) do
    %Post{}
    |> Post.create_changeset(attrs)
    |> Repo.insert()
    |> notify_subscribers(:created)
  end

  def update(%Post{} = post, attrs) do
    post
    |> Post.update_changeset(attrs)
    |> Repo.update()
  end

  def get_posts_in_forum(forum_id) do
    query =
      from(p in Post,
        where: p.id == ^forum_id,
        preload: [:replies],
        select: p
      )

    Repo.all(query)
  end

  def get(id) do
    Repo.get(Post, id)
  end

  def delete(id) do
    post = Repo.get(Post, id)
    Repo.delete(post)
  end
end
