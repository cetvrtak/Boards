defmodule Vision.Repo.Migrations.AddMembersAsMap do
  use Ecto.Migration

  def change do
  	alter table(:boards) do
  		add :members, :map
  	end
  end
end
