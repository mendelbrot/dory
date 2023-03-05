defmodule Dory.Forums do
  import Ecto.Query, warn: false
  alias Dory.Repo
  alias Dory.Forums.{Forum, ForumUser}

  def create_forum(attrs, forum_user_ids) do
    forum_users =
      forum_user_ids
      |> Enum.map(fn id -> %ForumUser{user_id: id} end)

    %Forum{}
    |> Profile.create_changeset(attrs, forum_users)
    |> Repo.insert()
  end

  def update_forum(%Forum{} = forum, attrs, current_user_id) do
    forum
    |> Profile.update_changeset(attrs)
    |> Repo.update()
  end

  def get_forums(id, current_user_id) do
    Repo.get(Forum, id)
  end

  def get_forum(id, current_user_id) do
    Repo.get(Forum, id)
  end

  def get_forum_by_name(name, current_user_id) do
    Forum
    |> Repo.get_by(Forum, name: name)
  end

  def delete_forum(id, current_user_id) do
    Repo.get(Forum, id)
  end

  def create_forum_user(%ForumUser{} = forum_user, current_user_id) do
  end

  def get_forum_user(%ForumUser{} = forum_user, current_user_id) do
  end

  def delete_forum_user(id, current_user_id) do
  end
end
