defmodule Sgiath.Router do
  use Sgiath, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :put_root_layout, {Sgiath.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]

    plug CORSPlug
  end

  pipeline :xml do
    plug :accepts, ["xml"]
  end

  scope "/", Sgiath do
    pipe_through :browser

    get "/", PageController, :index
    get "/projects", PageController, :projects
    get "/talks", PageController, :talks
    get "/now", PageController, :now
    get "/uses", PageController, :uses
    get "/libraries", PageController, :libraries
  end

  scope "/", Sgiath do
    pipe_through :xml

    get "/sitemap", SitemapController, :index
  end

  # not actually used in production
  scope "/presentations", Sgiath do
    pipe_through :browser

    get "/", PresentationsController, :index
    get "/elixir", PresentationsController, :elixir
    get "/bitcoin", PresentationsController, :bitcoin
  end

  scope "/.well-known/matrix", Sgiath do
    pipe_through :api

    get "/server", MatrixController, :server
    get "/client", MatrixController, :client
  end
end
