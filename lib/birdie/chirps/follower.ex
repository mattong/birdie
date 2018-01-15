defmodule Birdie.Chirps.Follow do
  use Ecto.Schema
  import Ecto.Changeset
  alias Birdie.Repo

  schema "follows" do
    belongs_to :following, Birdie.Chirps.Author
    belongs_to :follower, Birdie.Chirps.Author
  end

  def changeset(struct, %{following: following, follower: follower} = params \\ %{}) do
    struct
    |> Repo.preload([:follower, :following])
    |> cast(params, [])
    |> put_assoc(:following, following)
    |> put_assoc(:follower, follower)
  end
end
