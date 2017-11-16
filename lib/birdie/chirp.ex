defmodule Birdie.Chirp do
  use Ecto.Schema
  import Ecto.Changeset
  alias Birdie.Chirp


  schema "chirps" do
    field :content, :string
    field :timestamp, :date

    belongs_to :users, Birdie.User

    timestamps()
  end

  @doc false
  def changeset(%Chirp{} = chirp, attrs) do
    chirp
    |> cast(attrs, [:content, :timestamp])
    |> validate_required([:content, :timestamp])
  end
end
