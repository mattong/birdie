defmodule Birdie.Chirps.Dashboard do
  alias Birdie.Chirps.{
    Chirp,
    Follow
  }
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
    |> where(author_id: ^user_id)
    |> preload(:author)
    |> order_by([desc: :inserted_at])
    |> Repo.all()
  end

  def list_user_feed(%{id: user_id}) do
    chirp_query = from(c in Chirp,
      join: f in Follow,
      on: f.following_id == c.author_id,
      where: f.follower_id == ^user_id,
      or_where: c.author_id == ^user_id,
      order_by: [desc: :inserted_at],
      preload: :author
    )

    Repo.all(chirp_query)
  end
end
