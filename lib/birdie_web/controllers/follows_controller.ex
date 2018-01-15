defmodule BirdieWeb.FollowsController do
  use BirdieWeb, :controller
  alias Birdie.Chirps.Chirper

  def follow(%Plug.Conn{assigns: %{current_user: current_user}} = conn, %{"user_id" => user_id}) do
    follower = Chirper.get_user(current_user.id)
    following = Chirper.get_user(user_id)
    case Chirper.follow_user(%{follower: follower, following: following}) do
      {:ok, %{following: following}} ->
        conn
        |> put_flash(:info, "You have successfuly followed #{following.handle}")
        |> redirect(to: profile_path(conn, :index, following.handle))
      {:error, _} ->
        conn
        |> put_flash(:error, "Something went wrong!")
        |> redirect(to: profile_path(conn, :index, following))
    end
  end

  def unfollow(%Plug.Conn{assigns: %{current_user: current_user}} = conn, %{"user_id" => user_id}) do
    follower = Chirper.get_user(current_user.id)
    following = Chirper.get_user(user_id)
    Chirper.unfollow_user(follower, following)

    conn
    |> put_flash(:info, "You have successfuly unfollowed #{following.handle}")
    |> redirect(to: profile_path(conn, :index, following.handle))
  end
end
