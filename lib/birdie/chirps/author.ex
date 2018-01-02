defmodule Birdie.Chirps.Author do
  use Ecto.Schema
  import Ecto.Changeset
  alias Birdie.Chirps.Author

  schema "users" do
    field :username, :string

    has_many :chirps, Birdie.Chirps.Chirp

    timestamps()
  end

  @doc false
  def changeset(%Author{} = author, attrs) do
    author
    |> cast(attrs, [:username])
    |> validate_required([:username])
  end
end
