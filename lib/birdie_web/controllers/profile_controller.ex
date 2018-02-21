defmodule BirdieWeb.ProfileController do
  use BirdieWeb, :controller
  alias Birdie.Chirps.{
    Dashboard,
    Chirper
  }

  def index(%Plug.Conn{assigns: %{current_user: current_user}} = conn, %{"user_name" => username}) do
    user = Chirper.get_user_by_handle(username)
    chirps = Dashboard.list_user_chirps(user.id)
    changeset = Dashboard.new_chirp()
    follows = Chirper.does_user_follow(current_user.id, user.id)
    following_count = Chirper.get_following(user.id) |> length
    follower_count = Chirper.get_followers(user.id) |> length

    show_button =
      current_user
      |> is_current_user?(user)
      |> show_button(follows)

    render(conn, "index.html",
      user: user,
      chirps: chirps,
      show_button: show_button,
      following_count: following_count,
      follower_count: follower_count,
      current_user: current_user,
      changeset: changeset)
  end

  defp is_current_user?(user, user), do: true
  defp is_current_user?(user, current_user), do: false

  defp show_button(false, false), do: :follow_button
  defp show_button(false, true), do: :unfollow_button
  defp show_button(_, _), do: nil
end
