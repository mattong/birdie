defmodule BirdieWeb.Api.FeedView do
  use BirdieWeb, :view

  def render("feed.json", %{chirps: chirps}) do
    %{
      chirps: render_many(chirps, BirdieWeb.Api.ChirpView, "chirp.json")
    }
  end
end
