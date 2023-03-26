defmodule Dory.Repo.Migrations.CreatePostsTable do
  use Ecto.Migration

  @moduledoc """
  a thread is a collection of posts

  ref_id is the first post of the thread:

  - a post starting a new thread will have: post_to_main_feed=true and ref_id will default to it's own id.
  - a post replying to a thread will have: post_to_main_feed=false and ref_id=the id of the first post of the thread
  - a post replying to a thread and also posting to the main feed will have: post_to_main_feed=true and ref_id=the id of the first post of the thread

  when creating a new post, if ref_id is not set, a trigger will set it to this posts own id.
  """

  def change do
    create table(:posts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :forum_id, references(:forums, type: :uuid, on_delete: :delete_all), null: false
      add :thread_id, references(:threads, type: :uuid, on_delete: :delete_all), null: false
      add :user_id, references(:users, type: :uuid)
      # the first post of the thread
      add :ref_id, references(:posts, type: :uuid)
      # will show on main feed if value is true
      add :post_to_main_feed, :boolean
      add :body, :string
      timestamps()
    end

    create index(:posts, [:forum_id])
    create index(:posts, [:thread_id])
    create index(:posts, [:forum_id, :user_id])

    # a function to set the default ref_id.
    execute """
    create function post_default_ref_id ()
    returns trigger as $$
    begin
      new.ref_id := new.id;
      return new;
    end;
    $$ language plpgsql;
    """

    # the trigger only executes the function if ref_id is null
    execute """
    create trigger post_default_ref_id
      before insert on posts
      for each row
      when (new.ref_id is null)
      execute procedure post_default_ref_id ();
    """
  end
end
