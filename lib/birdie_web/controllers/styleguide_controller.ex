defmodule BirdieWeb.StyleguideController do
  use BirdieWeb, :controller

  plug :put_layout, "styleguide.html"

  def index(conn, _params) do
    render conn, "index.html"
  end
end
