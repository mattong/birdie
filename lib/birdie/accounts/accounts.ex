defmodule Birdie.Accounts do
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
end
