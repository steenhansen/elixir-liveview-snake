defmodule MultiGame.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      MultiGameWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: MultiGame.PubSub},
      # Start Finch
      {Finch, name: MultiGame.Finch},
      # Start the Endpoint (http/https)
      MultiGameWeb.Presence,
      MultiGameWeb.Endpoint,
      # Start a worker by calling: MultiGame.Worker.start_link(arg)
      # {MultiGame.Worker, arg}
      CollectParticipants
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MultiGame.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MultiGameWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
