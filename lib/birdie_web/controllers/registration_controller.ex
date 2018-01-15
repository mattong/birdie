defmodule BirdieWeb.RegistrationController do
  use BirdieWeb, :controller

  alias Birdie.Accounts
  alias Birdie.Chirps.Chirper

  def new(conn, _params) do
    changeset = Accounts.new_user()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => params}) do
    case Accounts.create_user(params) do
      {:ok, user} ->
        conn
        |> assign(:user_id, user.id)
        |> put_flash(:info, "Welcome to Birdie")
        |> new_profile(params)
      {:error, _} ->
        conn
        |> put_flash(:error, "Something went wrong!")
        |> redirect(to: registration_path(conn, :new))
    end
  end

  def new_profile(conn, _params) do
    changeset = Chirper.new_user()
    render(conn, "new_profile.html", changeset: changeset)
  end

  def create_user_profile(conn, %{"author" => params}) do
    case Chirper.create_user(params["user_id"], params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Welcome to Birdie")
        |> redirect(to: session_path(conn, :new))
      {:error, _} ->
        conn
        |> put_flash(:error, "Something went wrong!")
        |> redirect(to: registration_path(conn, :new))
    end
  end
end
