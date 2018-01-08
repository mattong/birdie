defmodule Birdie.Accounts.Follow do
  use Ecto.Schema
  import Ecto.Changeset

  schema "follows" do
    belongs_to :following, Birdie.Accounts.User
    belongs_to :follower, Birdie.Accounts.User
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:following, :follower])
  end
end
