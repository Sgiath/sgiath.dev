defmodule Sgiath.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Phoenix.PubSub, name: Sgiath.PubSub},
      Sgiath.Endpoint
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Sgiath.Supervisor)
  end

  @impl true
  def config_change(changed, _new, removed) do
    Sgiath.Endpoint.config_change(changed, removed)
    :ok
  end
end
