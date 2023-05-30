defmodule Web.Router do
  use Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :put_root_layout, {Web.Layouts, :root}
  end

  scope "/", Web do
    pipe_through :browser

    get "/", PageController, :index
    get "/now", PageController, :now
    get "/uses", PageController, :uses
    get "/nostr", PageController, :nostr
    get "/atak", PageController, :atak
  end

  scope "/presentations", Web do
    pipe_through :browser

    get "/", PresentationsController, :index
    get "/elixir", PresentationsController, :elixir
    get "/bitcoin", PresentationsController, :bitcoin
  end
end
