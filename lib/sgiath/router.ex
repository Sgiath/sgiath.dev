defmodule Sgiath.Router do
  use Sgiath, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :put_root_layout, {Sgiath.Layouts, :root}
  end

  scope "/", Sgiath do
    pipe_through :browser

    get "/", PageController, :index
    get "/now", PageController, :now
    get "/uses", PageController, :uses
    get "/libraries", PageController, :libraries
    get "/atak", PageController, :atak
  end

  # not actually used in production
  scope "/presentations", Sgiath do
    pipe_through :browser

    get "/", PresentationsController, :index
    get "/elixir", PresentationsController, :elixir
    get "/bitcoin", PresentationsController, :bitcoin
  end
end
