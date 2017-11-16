defmodule BirdieWeb.PageController do
  use BirdieWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
