defmodule Birdie.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :password, :string, virtual: true
    field :hashed_password, :string
    field :email, :string

    timestamps()
  end

  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:password, :email])
    |> validate_required([:password, :email])
  end

  def auth_changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
  end
end
