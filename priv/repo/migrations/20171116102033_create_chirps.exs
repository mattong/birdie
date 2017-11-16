defmodule Birdie.Repo.Migrations.CreateChirps do
  use Ecto.Migration

  def change do
    create table(:chirps) do
      add :content, :string
      add :timestamp, :date

      timestamps()
    end

  end
end
