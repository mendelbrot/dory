defmodule Dory.Repo.Migrations.CreateProfilesTable do
  use Ecto.Migration

  def change do
    create table(:profiles, primary_key: false) do
      add :user_id, references(:users, on_delete: :delete_all), primary_key: true
      add :username, :citext, null: false
      add :icon, :string
      add :icon_color, :string
      timestamps()
    end

    create unique_index(:profiles, [:username])
  end
end
