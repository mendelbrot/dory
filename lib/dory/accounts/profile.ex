defmodule Dory.Accounts.Profile do
  use Dory.Schema
  import Ecto.Changeset
  alias Dory.Accounts.User

  schema "profiles" do
    field :username, :string
    field :icon, :string
    belongs_to :user, User
    timestamps()
  end

  @doc """
  a changeset for creating a user profile
  - a unique username is required
  """
  def create_changeset(profile, attrs) do
    profile
    |> cast(attrs, [:user_id, :username, :icon])
    |> validate_required([:user_id, :username])
    |> unique_constraint(:user_id)
    |> unique_constraint(:username)
  end

  @doc """
  a changeset for updating a user profile
  """
  def update_changeset(profile, attrs) do
    profile
    |> cast(attrs, [:username, :icon])
    |> unique_constraint(:username)
  end
end
