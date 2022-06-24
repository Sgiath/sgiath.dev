defmodule Sgiath.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the PubSub system
      {Phoenix.PubSub, name: Sgiath.PubSub}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Sgiath.Supervisor)
  end
end
