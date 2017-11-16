defmodule Birdie.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :content, :string
      add :timestamp, :utc_datetime

      timestamps()
    end

  end
end
