defmodule BirdieWeb.RegistrationController do
  use BirdieWeb, :controller

  alias Birdie.Accounts

  def new(conn, _params) do
    changeset = Accounts.new_user()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => params}) do
    case Accounts.create_user(params) do
      {:ok, user} -> 
        conn
        |> put_flash(:info, "Welcome to Birdie")
        |> redirect(to: session_path(conn, :new))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Something went wrong!")
        |> redirect(to: registration_path(conn, :new))
    end
  end
end
