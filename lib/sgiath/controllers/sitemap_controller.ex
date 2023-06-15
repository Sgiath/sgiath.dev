defmodule Sgiath.SitemapController do
  use Sgiath, :controller

  import Saxy.XML

  @prolog [version: "1.0", encoding: "UTF-8"]

  def index(conn, _params) do
    data = [
      ~p"/",
      ~p"/now",
      ~p"/uses",
      ~p"/atak",
      ~p"/libraries",
      ~p"/presentations",
      ~p"/presentations/elixir",
      ~p"/presentations/bitcoin"
    ]

    urls = Enum.map(data, &element(:url, [], [element(:loc, [], "https://sgiath.dev#{&1}")]))
    root = element(:urlset, [xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9"], urls)

    xml(conn, Saxy.encode!(root, @prolog))
  end

  defp xml(conn, data) do
    conn
    |> put_resp_content_type("application/xml")
    |> send_resp(200, data)
  end
end
