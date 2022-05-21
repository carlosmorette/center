defmodule Center.Schemas.Individual do
  use Ecto.Schema
  import Ecto.Changeset

  alias Center.Repo
  alias Center.Schemas.{Family, Individual}

  @positions [
    :father,
    :son,
    :cousin,
    :friend,
    :uncle,
    :grandfather
  ]

  schema "individuals" do
    field :nickname, :string
    field :position, Ecto.Enum, values: @positions
    belongs_to :family, Family

    timestamps()
  end

  def changeset(individual, attrs) do
    individual
    |> cast(attrs, [:nickname, :position, :family_id])
    |> validate_required([:nickname])
  end

  def create(%{
        family_id: nil,
        position: position
      })
      when not is_nil(position),
      do: {:error, "individual needs to have a family"}

  def create(data) do
    %Individual{}
    |> changeset(data)
    |> Repo.insert()
  end

  def find(id: id) do
    Repo.get(Individual, id)
  end
end
