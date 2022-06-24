defmodule Web.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      Web.Telemetry,
      # Start the Endpoint (http/https)
      Web.Endpoint
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Web.Supervisor)
  end

  @impl true
  def config_change(changed, _new, removed) do
    Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
