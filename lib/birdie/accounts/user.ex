defmodule Birdie.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :password, :string, virtual: true
    field :password_hash, :string
    field :email, :string

    timestamps()
  end

  def create_changeset(struct, attrs \\ %{}) do
    struct
    |> changeset(attrs)
    |> put_pass_hash()
  end

  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:password, :email])
    |> validate_required([:password, :email])
  end

  def auth_changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true,
       changes: %{password: password}} = changeset) do
    change(changeset, Comeonin.Argon2.add_hash(password))
  end
end
