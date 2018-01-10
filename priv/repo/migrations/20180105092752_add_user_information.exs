defmodule Birdie.Repo.Migrations.AddUserInformation do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :handle, :string
      add :name, :string
    end
  end
end
