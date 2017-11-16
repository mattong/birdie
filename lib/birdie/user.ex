defmodule Birdie.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Birdie.User


  schema "users" do
    field :username, :string

    has_many :chirps, Birdie.Chirps

    timestamps()
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username])
    |> validate_required([:username])
  end
end
