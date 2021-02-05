defmodule Vision.Members.Member do
  use Ecto.Schema
  import Ecto.Changeset

  schema "members" do
    field :role, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(member, attrs) do
    member
    |> cast(attrs, [:username, :role])
    |> validate_required([:username, :role])
  end
end
