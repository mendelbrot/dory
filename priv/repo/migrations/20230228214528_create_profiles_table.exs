defmodule Dory.Repo.Migrations.CreateProfilesTable do
  use Ecto.Migration

  def change do
    create table(:profiles, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, type: :uuid, on_delete: :delete_all)
      add :username, :citext, null: false
      add :icon, :string
      timestamps()
    end

    create unique_index(:profiles, [:user_id])
    create unique_index(:profiles, [:username])
  end
end
