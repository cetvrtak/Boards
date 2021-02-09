defmodule Vision.Repo.Migrations.CreateLists do
  use Ecto.Migration

  def change do
    create table(:lists) do
      add :title, :string
      add :tasks, {:array, :string}

      timestamps()
    end

  end
end
