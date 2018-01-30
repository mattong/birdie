defmodule BirdieWeb.Api.ChirpView do
  use BirdieWeb, :view

  def render("chirp.json", %{chirp: chirps}) do
    %{
      id: chirps.id,
      timestamp: chirps.inserted_at,
      author: chirps.author.handle,
      content: chirps.content
    }
  end
end
