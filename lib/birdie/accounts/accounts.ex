defmodule Birdie.Accounts do
  alias Birdie.Accounts.User

  def list()  do
    User
    |> Birdie.Repo.all()
  end
  def new_user(params \\ %{}) do
    %User{}
    |> User.changeset(params)
  end

  def create_user(params \\ %{}) do
    %User{}
    |> User.create_changeset(params)
    |> Birdie.Repo.insert()
  end

  def get_user(user_id) do
    User
    |> Birdie.Repo.get_by!(%{id: user_id})
  end
end
