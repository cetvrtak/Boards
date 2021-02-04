defmodule Vision.Repo.Migrations.RemoveMembersAsString do
  use Ecto.Migration

  def change do
  	alter table(:boards) do
  		remove :members
  	end
  end
end
