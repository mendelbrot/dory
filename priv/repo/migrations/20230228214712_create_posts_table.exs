defmodule Dory.Repo.Migrations.CreatePostsTable do
  use Ecto.Migration

  @moduledoc """
  a thread is a collection of posts that all share the same ref_id.
  this is not an actual table.  the posts are grouped into threads dynamically by
  the ref_id attribute.  ref_id is the first post of the thread:

  - a post starting a new thread will have: post_to_main_feed=true and ref_id will default to it's own id.
  - a post replying to a thread will have: post_to_main_feed=false and ref_id=the id of the first post of the thread
  - a post replying to a thread and also posting to the main feed will have: post_to_main_feed=true and ref_id=the id of the first post of the thread

  when creating a new post, if ref_id is not set, a trigger will set it to this posts own id.
  """

  def change do
    create table(:posts) do
      add :forum_id, references(:forums, on_delete: :delete_all), null: false
      add :user_id, references(:users)
      # the first post of the thread
      add :ref_id, references(:posts)
      # will show on main feed if value is true
      add :post_to_main_feed, :boolean
      add :body, :string
      timestamps()
    end

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
