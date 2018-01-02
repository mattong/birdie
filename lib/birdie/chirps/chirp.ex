defmodule Birdie.Chirps.Chirp do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chirps" do
    field :content, :string
    field :timestamp, :date

    belongs_to :author, Birdie.Chirps.Author # Birdie.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = chirp, attrs) do
    chirp
    |> cast(attrs, [:content, :timestamp])
    |> validate_required([:content, :timestamp])
  end
end

