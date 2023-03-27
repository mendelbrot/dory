defmodule Dory.Repo.Migrations.ForumViews do
  use Ecto.Migration

  def change do
    execute """
    create view posts_vm as
      select
        p.*,
        pr.username
      from
        posts p
      inner join
        profiles pr
      on
        p.user_id = pr.user_id
      order by p.inserted_at asc;
    """
  end
end
