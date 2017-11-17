defmodule Birdie.Repo.Migrations.AddUserId do
  use Ecto.Migration

  def change do
    alter table(:chirps) do
      add :users_id, references(:users)
    end
  end
end
