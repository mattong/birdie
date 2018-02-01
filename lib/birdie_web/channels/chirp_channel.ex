defmodule BirdieWeb.ChirpChannel do
  use Phoenix.Channel

  def join("chirp:feed", _message, socket) do
    {:ok, socket}
  end

  def handle_in("new_chirp", %{"user" => user}, socket) do
    broadcast! socket, "new_chirp", %{user: user}
    {:noreply, socket}
  end
end
