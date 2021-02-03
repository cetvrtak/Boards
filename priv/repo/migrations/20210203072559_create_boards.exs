defmodule Vision.Repo.Migrations.CreateBoards do
  use Ecto.Migration

  def change do
    create table(:boards) do
      add :title, :string
      add :owner, :string
      add :team_name, :string
      add :members, :string

      timestamps()
    end

  end
end
