defmodule Birdie.Accounts do
  alias Birdie.Accounts.User

  def new_user(params \\ %{}) do
    %User{}
    |> User.changeset(params)
  end

  def create_user(params \\ %{}) do
    %User{}
    |> User.changeset(params)
    |> Birdie.Repo.insert()
  end

end
