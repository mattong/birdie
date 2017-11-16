defmodule Birdie.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Birdie.Account.User


  schema "users" do
    field :firstname, :string
    field :lastname, :string
    field :password, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :firstname, :lastname, :password])
    |> validate_required([:username, :firstname, :lastname, :password])
  end
end
