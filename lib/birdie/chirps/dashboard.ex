defmodule Birdie.Chirps.Dashboard do
  alias Birdie.Chirps.Chirp

  def list() do
    Chirp
    |> Birdie.Repo.all()
  end

  def new_chirp(params \\ %{}) do
    %Chirp{}
    |> Chirp.changeset(params)
  end

  def create_chirp(params \\ %{}) do
    %Chirp{}
    |> Chirp.changeset(params)
    |> Birdie.Repo.insert()
  end
end
