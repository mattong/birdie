defmodule Birdie.Chirps.Chirp do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chirps" do
    field :content, :string
    field :timestamp, :naive_datetime

    belongs_to :author, Birdie.Chirps.Author # Birdie.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = chirp, attrs) do
    chirp
    |> cast(attrs, [:content, :timestamp, :author_id])
    |> validate_required([:content])
  end
end

