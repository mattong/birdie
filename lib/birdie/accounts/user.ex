defmodule Birdie.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Birdie.Accounts.{
    User,
    Follow
  }

  schema "users" do
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string
    field :email, :string

    timestamps()
  end

  @valid_attrs [
    :password,
    :email
  ]

  def create_changeset(struct, attrs \\ %{}) do
    struct
    |> changeset(attrs)
    |> put_pass_hash()
  end

  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, @valid_attrs)
    |> validate_required([:password, :email])
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true,
       changes: %{password: password}} = changeset) do
    change(changeset, Comeonin.Argon2.add_hash(password))
  end
end
