defmodule Vision.Repo.Migrations.RemMembers do
  use Ecto.Migration

  def change do
  	alter table(:boards) do
  		remove :members
  	end
  end
end
