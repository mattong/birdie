defmodule Birdie.Repo.Migrations.ChangeNameToLastNameAndFirstName do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :last_name, :string
      add :first_name, :string
      remove :name
    end
  end
end
