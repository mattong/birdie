defmodule BirdieWeb.FollowsController do
  use BirdieWeb, :controller
  alias Birdie.Accounts

  def follow(%Plug.Conn{assigns: %{current_user: current_user}} = conn, %{"user_id" => user_id}) do
    follower = current_user
    following = Accounts.get_user(user_id)
    case Accounts.follow_user(%{follower: follower, following: following}) do
      {:ok, %{following: following}} ->
        require IEx
        IEx.pry
        conn
        |> put_flash(:info, "You have successfuly followed #{following.name}")
        |> redirect(to: profile_path(conn, :index, following.handle))
      {:error, _} ->
        conn
        |> put_flash(:error, "Something went wrong!")
        |> redirect(to: profile_path(conn, :index, following))
    end
  end
end
