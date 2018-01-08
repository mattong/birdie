defmodule BirdieWeb.FollowController do
  use BirdieWeb, :controller
  alias Birdie.Accounts

  def follow(%Plug.Conn{assigns: %{current_user: current_user}} = conn, %{user: user}) do
    case Accounts.follow_user(%{follower_id: current_user.id, following_id: user.id}) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "You have successfuly followed #{user.name}")
        |> redirect(to: profile_path(conn, :index, user.handle))
      {:error, _} ->
        conn
        |> put_flash(:error, "Something went wrong!")
        |> redirect(to: profile_path(conn, :index, user.handle))
    end
  end
end
