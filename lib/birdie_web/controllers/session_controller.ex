defmodule BirdieWeb.SessionController do
  use BirdieWeb, :controller
  alias Birdie.Repo

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"email" => email, "password" => password}) do
    case Birdie.Plug.Auth.user_auth(conn, email, password, repo: Repo) do
      {:ok, conn} ->
        user = Repo.get(User, conn.current_user)
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: BirdieWeb.Router.Helpers.user_path(conn, :show, user))
      {:error, _, _} ->
        conn
        |> put_flash(:error, "Nope!")
        |> redirect(to: BirdieWeb.Router.Helpers.session_path(conn, :new))
    end
  end

  def delete(conn, _params) do
    conn
    |> Birdie.Plug.Auth.sign_out()
    |> put_flash(:info, "Bye felicia!")
    |> redirect(to: BirdieWeb.Router.Helpers.session_path(conn, :new)) #ask about this
  end
end
