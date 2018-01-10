defmodule Birdie.Accounts do
  import Ecto.Query
  alias Birdie.Repo
  alias Birdie.Accounts.{
    User,
    Follow
  }

  def list()  do
    User
    |> Repo.all()
  end

  def new_user(params \\ %{}) do
    %User{}
    |> User.changeset(params)
  end

  def create_user(params \\ %{}) do
    %User{}
    |> User.create_changeset(params)
    |> Repo.insert()
  end

  def get_user(user_id) do
    User
    |> Repo.get_by!(%{id: user_id})
  end

  def get_user_by_handle(handle) do
    User
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
  end

  def get_followers(user_id) do
    from([f] in Follow,
      where: f.following_id == ^user_id)
    |> Repo.all()
    |> Repo.preload([:follower])
  end
end
