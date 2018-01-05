defmodule BirdieWeb.PageController do
  use BirdieWeb, :controller
  alias Birdie.Accounts
  alias Birdie.Chirps.Dashboard

  def index(conn, _params) do
    chirps = Dashboard.list()
    changeset = Dashboard.new_chirp()
    render(conn, "index.html", user: conn.assigns.current_user, chirps: chirps, changeset: changeset)
  end
end
