defmodule Vision.Boards.Board do
  use Ecto.Schema
  import Ecto.Changeset

  schema "boards" do
    field :owner, :string
    field :team_name, :string
    field :title, :string
    has_many :members, Vision.Members.Member
    has_many :lists, Vision.Boards.List

    timestamps()
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [:title, :owner, :team_name])
    |> validate_required([:title, :owner, :team_name])
  end
end
