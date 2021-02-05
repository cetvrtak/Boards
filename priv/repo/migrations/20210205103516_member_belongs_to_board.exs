defmodule Vision.Repo.Migrations.MemberBelongsToBoard do
  use Ecto.Migration

  def change do
  	alter table(:members) do
  		add :board_id, references (:boards)
  	end
  end
end
