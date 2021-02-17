defmodule Remind.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    
    :ets.new(:storage, [:named_table, :public])

#    spawn_link(Remind.SendRemind.SendingRemind, :start, [])

    children = [
      # Start the Ecto repository
      Remind.Repo,
      # Start the Telemetry supervisor
      RemindWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Remind.PubSub},
      # Start the Endpoint (http/https)
      RemindWeb.Endpoint,
      # Start a worker by calling: Remind.Worker.start_link(arg)
      # {Remind.Worker, arg}
      %{
        id: Launch,
        start: {Remind.Application, :launch, []}
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Remind.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    RemindWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  def launch() do
    {:ok, spawn_link(Remind.SendRemind.SendingRemind, :start, [])}
  end
end
