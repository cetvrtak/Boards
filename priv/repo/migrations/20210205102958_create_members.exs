defmodule Vision.Repo.Migrations.CreateMembers do
  use Ecto.Migration

  def change do
    create table(:members) do
      add :username, :string
      add :role, :string

      timestamps()
    end

  end
end
