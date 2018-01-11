defmodule Birdie.Chirps.Dashboard do
  alias Birdie.Chirps.Chirp
  alias Birdie.Accounts.{
    User,
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
    |> where(user_id: ^user_id)
    |> preload(:user)
    |> order_by([desc: :inserted_at])
    |> Repo.all()
  end

  def list_user_feed(%{id: user_id}) do
    following_list =
      from(
        f in Follow,
        where: f.follower_id == ^user_id,
        select: f.following_id
      )
      |> Repo.all()

    chirp_query = from(c in Chirp,
      where: c.user_id in ^following_list,
      or_where: c.user_id == ^user_id,
      order_by: [desc: :inserted_at],
      preload: :user
    )

    Repo.all(chirp_query)
  end
end
