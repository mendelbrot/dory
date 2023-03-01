defmodule Dory.Repo.Migrations.CreateForumsTable do
  use Ecto.Migration

  def change do
    create table(:forums) do
      add :name, :citext, null: false
      timestamps(updated_at: false)
    end

    create unique_index(:forums, [:name])

    create table(:forum_users, primary_key: false) do
      add :forum_id, references(:forums, on_delete: :delete_all), primary_key: true
      add :user_id, references(:users, on_delete: :delete_all), primary_key: true
      timestamps(updated_at: false)
    end
  end
end
