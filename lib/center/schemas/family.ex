defmodule Center.Schemas.Family do
  use Ecto.Schema
  import Ecto.Changeset

  alias Center.Repo
  alias Center.Schemas.{Family, Individual}

  schema "families" do
    field :name, :string
    has_many :individuals, Individual

    timestamps()
  end

  def changeset(family, attrs) do
    cast(family, attrs, [:name])
  end

  def create(data) do
    %Family{}
    |> changeset(data)
    |> Repo.insert()
  end

  def find(id: id) do
    Repo.get(Family, id)
  end

  def find_all() do
    Repo.all(Family)
  end
end
