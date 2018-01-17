defmodule Birdie.Chirps.Chirper do
  import Ecto.Query
  alias Birdie.Repo
  alias Birdie.Chirps.{
    Follow,
    Author
  }

  def new_user() do
    Author.changeset(%Author{})
  end

  def create_user(id, params \\ %{}) do
    Author
    |> does_exist?(id)
    |> Author.create_changeset(params)
    |> Repo.insert_or_update()
  end

  def get_user(user_id) do
    Repo.get(Author, user_id)
  end

  def get_user_by_handle(handle) do
    Author
    |> Repo.get_by(%{handle: handle})
  end

  def follow_user(params) do
    %Follow{}
    |> Follow.changeset(params)
    |> Repo.insert()
  end

  def unfollow_user(%{id: follower_id}, %{id: following_id}) do
    from([f] in Follow,
      where: f.follower_id == ^follower_id,
      where: f.following_id == ^following_id)
    |> Repo.delete_all()
  end

  def does_user_follow(follower_id, following_id) do
    Follow
    |> Repo.get_by(%{follower_id: follower_id, following_id: following_id})
    |> is_map()
  end

  def get_following(user_id) do
    from([f] in Follow,
      where: f.follower_id == ^user_id)
    |> Repo.all()
    |> Repo.preload([:following])
    |> Enum.map(fn(x) -> x.following end)
  end

  def get_followers(user_id) do
    from([f] in Follow,
      where: f.following_id == ^user_id)
    |> Repo.all()
    |> Repo.preload([:follower])
    |> Enum.map(fn(x) -> x.follower end)
  end

  defp does_exist?(struct, id) do
    case Repo.get(struct, id) do
      nil -> %Author{id: id}
      entry -> entry
    end
  end
end
