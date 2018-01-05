defmodule Birdie.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  defmodule Follower do
    use Persistence.Schema
    use Arc.Ecto.Schema

    embedded_schema do
      field :user_id, :binary_id
    end

    def changeset(struct, params \\ %{}) do
      struct
      |> cast(params, [:user_id])
    end
  end

  defmodule Following do
    use Persistence.Schema
    use Arc.Ecto.Schema

    embedded_schema do
      field :user_id, :binary_id
    end
  end

  schema "users" do
    field :password, :string, virtual: true
    field :password_hash, :string
    field :email, :string

    embeds_many :followers, Follower
    embeds_many :following, Following

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

  defp put_pass_hash(%Ecto.Changeset{valid?: true,
       changes: %{password: password}} = changeset) do
    change(changeset, Comeonin.Argon2.add_hash(password))
  end
end
