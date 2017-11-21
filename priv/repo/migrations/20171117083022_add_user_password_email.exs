defmodule Birdie.Repo.Migrations.AddUserPasswordEmail do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :password, :string
      add :email, :string
    end
  end
end
