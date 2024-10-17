defmodule Sgiath.MatrixController do
  use Sgiath, :controller

  def server(conn, _args) do
    json(conn, %{"m.server" => "matrix.sgiath.dev:443"})
  end

  def client(conn, _args) do
    json(conn, %{
      "m.server" => "https://matrix.sgiath.dev",
      "m.homeserver" => %{base_url: "https://matrix.sgiath.dev"}
    })
  end
end
