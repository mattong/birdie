defmodule Birdie.Chirp do
  use Ecto.Schema
  import Ecto.Changeset
  alias Birdie.Chirp


  schema "chirps" do
    field :content, :string
    field :timestamp, Ecto.DateTime 

    belongs_to :users, Birdie.User

    timestamps()
  end

  def changeset(chirp, attrs) do
    chirp
    |> cast(attrs, [:content, :timestamp])
    |> validate_required([:content])
  end
end
