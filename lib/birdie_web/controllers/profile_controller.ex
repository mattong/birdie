defmodule BirdieWeb.ProfileController do
  use BirdieWeb, :controller
  alias Birdie.Accounts
  alias Birdie.Chirps.Dashboard

  def index(%Plug.Conn{assigns: %{current_user: current_user}} = conn, %{"user_name" => username}) do
    user = Accounts.get_user_by_handle(username)
    chirps = Dashboard.list_user_chirps(current_user.id)
    changeset = Dashboard.new_chirp()
    follows = Accounts.does_user_follow(current_user.id, user.id)
    following = Accounts.get_following(user.id)
    followers = Accounts.get_followers(user.id)

    show_button = 
      current_user
      |> is_current_user?(user)
      |> show_button(follows)

    render(conn, "index.html",
      user: user,
      chirps: chirps,
      show_button: show_button,
      following_list: following,
      followers_list: followers,
      current_user: current_user,
      changeset: changeset)
  end

  defp is_current_user?(user, user), do: true
  defp is_current_user?(user, current_user), do: false

  defp show_button(false, false), do: :follow_button
  defp show_button(false, true), do: :unfollow_button
  defp show_button(_, _), do: nil
end
