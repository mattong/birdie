defmodule BirdieWeb.ChirpChannel do
  use Phoenix.Channel

  def join("chirp:feed", _message, socket) do
    {:ok, socket}
  end

  def handle_in("new_chirp", %{"body" => body, "user" => user, "id" => id}, socket) do
    broadcast! socket, "new_chirp", %{body: body, user: user, user_id: id}
    {:noreply, socket}
  end
end
