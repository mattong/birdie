defmodule BirdieWeb.Api.FeedController do
  use BirdieWeb, :controller
  alias Birdie.Chirps.{
    Chirper,
    Dashboard
  }

  def chirps(conn, %{"handle" => handle}) do
    user = Chirper.get_user_by_handle(handle)
    chirps = Dashboard.list_user_feed(user)
    render(conn, "feed.json", chirps: chirps)
  end

end
