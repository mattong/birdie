defmodule Birdie.Repo.Migrations.AddUserIdFieldToChirp do
  use Ecto.Migration

  def change do
    alter table(:chirps) do
      add :user_id, references(:users)
    end

  end
end
