defmodule BirdieWeb.PageController do
  use BirdieWeb, :controller
  alias Birdie.Accounts
  alias Birdie.Chirps.Dashboard

  def index(%Plug.Conn{assigns: %{current_user: current_user}} = conn, _params) do
    chirps = Dashboard.list_user_feed(current_user)
    changeset = Dashboard.new_chirp()
    render(conn, "index.html", user: current_user, chirps: chirps, changeset: changeset)
  end
end
