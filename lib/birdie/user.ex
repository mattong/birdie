defmodule Birdie.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Birdie.User


  schema "users" do
    field :username, :string

    has_many :chirps, Birdie.Chirp

    timestamps()
  end

  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:username])
    |> validate_required([:username])
  end
end
