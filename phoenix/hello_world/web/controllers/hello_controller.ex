defmodule HelloWorld.HelloController do
  use HelloWorld.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def show(conn, %{ "message" => string }) do
    render conn, "show.html", message: string
  end
end
