defmodule BirdieWeb.ChirpController do
  use BirdieWeb, :controller

  alias Birdie.{
    Chirp,
    Repo
  }

  def index(conn, _params) do
    chirp_list =
      Chirp
      #    |> Repo.preload(:users)
      |> Repo.all() 

    render(conn, "index.html", chirp_list: chirp_list)
  end
    
end
