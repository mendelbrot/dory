defmodule Dory.Repo.Migrations.CreateForumsTable do
  use Ecto.Migration

  def change do
    create table(:forums, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :citext, null: false
      timestamps(updated_at: false)
    end

    create unique_index(:forums, [:name])

    create table(:forum_users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :forum_id, references(:forums, type: :uuid, on_delete: :delete_all)
      add :user_id, references(:users, type: :uuid, on_delete: :delete_all)
      timestamps(updated_at: false)
    end

    create index(:forum_users, [:forum_id])
    create index(:forum_users, [:user_id])
    create unique_index(:forum_users, [:forum_id, :user_id])
  end
end
