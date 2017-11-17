defmodule BirdieWeb.RegistrationController do
  use BirdieWeb, :controller

  alias Birdie.{
    User
  }

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => params}) do
    changeset = User.changeset(%User{}, params)
    Birdie.Repo.insert!(changeset)

    conn
    |> put_flash(:info, "YAAAAS")
    |> render("new.html", changeset: changeset)
  end
end
