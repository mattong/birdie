defmodule BirdieWeb.UserController do
  use BirdieWeb, :controller
  alias Birdie.{
    Repo,
    User,
    Chirp
  }

  def index(conn, params) do
    render(conn, "profile.html")
  end

  def chirp(conn, params) do
    changeset = Chirp.changeset(params)

    Repo.insert!(changeset)

    conn
    |> put_flash(:info, "You chirped!")
    |> render(conn, "profile.html")
  end
end
