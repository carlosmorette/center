defmodule Center.Schemas.Responsability do
  use Ecto.Schema
  import Ecto.Changeset

  alias Center.Repo
  alias Center.Schemas.Responsability

  schema "responsabilities" do
    field :description, :string

    timestamps()
  end

  def changeset(responsability, attrs) do
    responsability
    |> cast(attrs, [:description])
  end

  def create(data) do
    %Responsability{}
    |> changeset(data)
    |> Repo.insert()
  end
end
