defmodule BirdieWeb.ChirpController do
  use BirdieWeb, :controller
  alias Birdie.Chirps.Dashboard

  def chirp(conn, %{"chirp" => chirp}) do
    chirp =
      chirp
      |> Map.put("author_id", conn.assigns.current_user.id)

    case Dashboard.create_chirp(chirp) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "You chirped!")
        |> redirect(to: page_path(conn, :index))
      {:error, _, _} ->
        conn
        |> put_flash(:error, "Something went wrong!")
        |> redirect(to: page_path(conn, :index))
    end
  end
end
