defmodule Vision.Lists.List do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lists" do
    field :tasks, {:array, :string}
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:title, :tasks])
    |> validate_required([:title, :tasks])
  end
end
