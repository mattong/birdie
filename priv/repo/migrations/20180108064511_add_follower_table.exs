defmodule Birdie.Repo.Migrations.AddFollowerTable do
  use Ecto.Migration

  def change do
    create table(:follows) do
      add :following_id, references(:users)
      add :follower_id, references(:users)
    end
    create unique_index(:follows, [:following_id, :follower_id])
  end
end
