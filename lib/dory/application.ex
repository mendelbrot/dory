defmodule Dory.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      DoryWeb.Telemetry,
      # Start the Ecto repository
      Dory.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Dory.PubSub},
      # Start Finch
      {Finch, name: Dory.Finch},
      # Start the Endpoint (http/https)
      DoryWeb.Endpoint
      # Start a worker by calling: Dory.Worker.start_link(arg)
      # {Dory.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Dory.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DoryWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
