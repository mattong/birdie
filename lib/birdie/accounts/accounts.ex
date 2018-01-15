defmodule Birdie.Accounts do
  import Ecto.Query
  alias Birdie.Repo
  alias Birdie.Accounts.User

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

end
