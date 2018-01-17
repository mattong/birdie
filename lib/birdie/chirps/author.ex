defmodule Birdie.Chirps.Author do
  use Ecto.Schema
  import Ecto.Changeset
  alias Birdie.Chirps.Author

  schema "users" do
    field :handle, :string
    field :first_name, :string
    field :last_name, :string

    has_many :chirps, Birdie.Chirps.Chirp

    many_to_many :following, Author, join_through: Follow
    many_to_many :follower, Author, join_through: Follow

    timestamps()
  end

  def create_changeset(%Author{} = author, attrs \\ %{}) do
    author
    |> changeset(attrs)
  end

  def changeset(%Author{} = author, attrs \\ %{}) do
    author
    |> cast(attrs, [:handle, :first_name, :last_name])
    |> validate_required([:handle, :first_name, :last_name])
  end
end
