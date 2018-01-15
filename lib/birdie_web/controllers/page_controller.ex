defmodule BirdieWeb.PageController do
  use BirdieWeb, :controller
  alias Birdie.Chirps.{
    Dashboard,
    Chirper
  }

  def index(%Plug.Conn{assigns: %{current_user: current_user}} = conn, _params) do
    user = Chirper.get_user(current_user.id)
    chirps = Dashboard.list_user_feed(current_user)
    changeset = Dashboard.new_chirp()
    render(conn, "index.html", user: user, chirps: chirps, changeset: changeset)
  end
end
