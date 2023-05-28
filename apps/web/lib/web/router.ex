defmodule Web.Router do
  use Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {Web.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
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

  if Application.compile_env(:web, :dev_routes, false) do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: Web.Telemetry
    end
  end
end
