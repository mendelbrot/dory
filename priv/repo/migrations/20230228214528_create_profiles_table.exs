defmodule Dory.Repo.Migrations.CreateProfilesTable do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :username, :citext, null: false
      add :icon, :string
      add :icon_color, :string
      timestamps()
    end

    create unique_index(:profiles, [:user_id])
    create unique_index(:profiles, [:username])
  end
end
