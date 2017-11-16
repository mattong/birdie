defmodule Birdie.Chirp.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Birdie.Chirp.Post


  schema "posts" do
    field :content, :string
    field :timestamp, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:content, :timestamp])
    |> validate_required([:content, :timestamp])
  end
end
