defmodule Vision.Boards.Board do
  use Ecto.Schema
  import Ecto.Changeset

  schema "boards" do
    field :members, :map
    field :owner, :string
    field :team_name, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [:title, :owner, :team_name])
    |> validate_required([:title, :owner, :team_name])
  end
end
