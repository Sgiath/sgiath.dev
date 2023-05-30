defmodule Sgiath.PresentationsController do
  use Sgiath, :controller

  def index(conn, _params) do
    render(conn, "index.html", page_title: "presentations")
  end

  def elixir(conn, _params) do
    render(conn, "elixir.html", page_title: "old is the new modern")
  end

  def bitcoin(conn, _params) do
    render(conn, "bitcoin.html", page_title: "introduction to bitcoin")
  end
end
