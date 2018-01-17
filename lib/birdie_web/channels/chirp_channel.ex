defmodule BirdieWeb.ChirpChannel do
  use Phoenix.Channel

  def join("chirp:feed", _message, socket) do
    {:ok, socket}
  end

  def handle_in("new_chirp", %{"body" => body}, socket) do
    broadcast! socket, "new_chirp", %{body: body}
    {:noreply, socket}
  end
end
