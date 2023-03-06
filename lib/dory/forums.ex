defmodule Dory.Forums do
  import Ecto.Query, warn: false
  alias Dory.Repo
  alias Dory.Accounts.User
  alias Dory.Forums.{Forum, ForumUser}

  def create(attrs, forum_user_ids \\ []) do
    forum_users =
      forum_user_ids
      |> Enum.map(fn id -> %ForumUser{user_id: id} end)

    %Forum{}
    |> Forum.create_changeset(attrs, forum_users)
    |> Repo.insert()
  end

  def update(%Forum{} = forum, attrs) do
    forum
    |> Forum.update_changeset(attrs)
    |> Repo.update()
  end

  def get_my(current_user_id) do
    query =
      from f in Forum,
        join: fu in ForumUser,
        on: f.id == fu.forum_id,
        where: fu.user_id == ^current_user_id,
        select: f

    Repo.all(query)
  end

  def get(id) do
    Repo.get(Forum, id)
  end

  def get_by_name(name) do
    Repo.get_by(Forum, name: name)
  end

  def delete(id) do
    forum = Repo.get(Forum, id)
    Repo.delete(forum)
  end

  def create_user_association(attrs) do
    %ForumUser{}
    |> ForumUser.create_changeset(attrs)
    |> Repo.insert()
  end

  def delete_user_association(id) do
    forum_user = Repo.get(ForumUser, id)
    Repo.delete(forum_user)
  end

  def get_user_associations(forum_id) do
    query =
      from fu in ForumUser,
        where: fu.forum_id == ^forum_id,
        select: fu

    Repo.all(query)
  end

  def get_associated_users(forum_id) do
    query =
      from u in User,
        join: p in Profile,
        on: p.user_id == u.id,
        join: fu in ForumUser,
        on: u.id == fu.user_id,
        where: fu.forum_id == ^forum_id,
        preload: [:profile],
        select: u

    Repo.all(query)
  end
end
