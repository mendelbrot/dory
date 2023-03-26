defmodule Dory.Repo.Migrations.CreateThreadsTable do
  use Ecto.Migration

  def change do
    create table(:threads, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :forum_id, references(:forums, type: :uuid, on_delete: :delete_all), null: false
      timestamps(updated_at: false)
    end

    create index(:threads, [:forum_id])
  end
end
