defmodule Birdie.Chirps.Dashboard do
  alias Birdie.Chirps.Chirp
  alias Birdie.Repo
  import Ecto.Query

  def list() do
    Chirp
    |> Repo.all()
  end

  def new_chirp(params \\ %{}) do
    %Chirp{}
    |> Chirp.changeset(params)
  end

  def create_chirp(params \\ %{}) do
    %Chirp{}
    |> Chirp.changeset(params)
    |> Repo.insert()
  end

  def list_user_chirps(user_id) do
    Chirp
    |> where(user_id: ^user_id)
    |> preload(:user)
    |> order_by([desc: :inserted_at])
    |> Repo.all()
  end
end
