defmodule BirdieWeb.SessionController do
  use BirdieWeb, :controller
  alias Birdie.{
    Accounts,
    Repo
  }

  plug :put_layout, "splash.html"

  def new(conn, _) do
    render conn, "new.html", changeset: Accounts.new_user(), action: session_path(conn, :create)
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Birdie.Plug.Auth.user_auth(conn, email, password, repo: Repo) do
      {:ok, conn} ->
        # user = Repo.get(User, conn.assigns.current_user.id)
        user = Accounts.get_user(conn.assigns.current_user.id)
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: page_path(conn, :index))
      {:error, _, _} ->
        conn
        |> put_flash(:error, "Nope!")
        |> redirect(to: session_path(conn, :new))
    end
  end

  def delete(conn, _params) do
    conn
    |> Birdie.Plug.Auth.sign_out()
    |> put_flash(:info, "Bye felicia!")
    |> redirect(to: session_path(conn, :new)) #ask about this
  end
end
