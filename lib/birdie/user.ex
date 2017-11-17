defmodule Birdie.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Birdie.User


  schema "users" do
    field :username, :string
    field :password, :string
    field :email, :string

    has_many :chirps, Birdie.Chirp

    timestamps()
  end

  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:username, :password, :email])
    |> validate_required([:username, :password, :email])
  end
end
