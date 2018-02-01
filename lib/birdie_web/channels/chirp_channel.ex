defmodule BirdieWeb.ChirpChannel do
  use Phoenix.Channel
  alias Birdie.Chirps.Dashboard
  alias Birdie.Repo

  def join("chirp:feed", _message, socket) do
    {:ok, socket}
  end

  def handle_in("new_chirp", %{"content" => content, "author_id" => author_id}, socket) do
    case Dashboard.create_chirp(%{content: content, author_id: author_id}) do
      {:ok, chirp} ->
        %{
          content: content,
          author: %{handle: handle},
          inserted_at: inserted_at
        } = Repo.preload(chirp, :author)
        broadcast! socket, "new_chirp", %{content: content, author: handle, timestamp: inserted_at}
        {:noreply, socket}
      {:error, _} ->
    end
  end
end
