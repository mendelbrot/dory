defmodule Dory.Repo do
  use Ecto.Repo,
    otp_app: :dory,
    adapter: Ecto.Adapters.Postgres
end
