defmodule Center.Schemas.IndividualResponsability do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Center.Repo
  alias Center.Schemas.{Individual, Responsability}

  schema "individual_responsability" do
    belongs_to :individual, Individual
    belongs_to :responsability, Responsability

    timestamps()
  end

  def changeset(ir, attrs) do
    ir
    |> cast(attrs, [:individual_id, :responsability_id])
    |> validate_required([:individual_id, :responsability_id])
  end

  def create(
        %{
          individual_id: _individual_id,
          responsability_id: _responsability_id
        } = data
      ) do
    with {:ok, _individual} <- check_individual_family(data),
         false <- exists_with_same?(data) do
      %__MODULE__{}
      |> changeset(data)
      |> Repo.insert()
    else
      {:error, error} ->
        {:error, error}

      true ->
        {:error, "individual already has that responsibility"}
    end
  end

  def check_individual_family(%{individual_id: individual_id}) do
    case Individual.find(id: individual_id) do
      nil ->
        {:error, "individual not found"}

      individual ->
        if not is_nil(individual.family_id) do
          {:ok, individual}
        else
          {:error, "individual needs to have a family"}
        end
    end
  end

  def exists_with_same?(%{individual_id: individual_id, responsability_id: responsability_id}) do
    query =
      from ir in __MODULE__,
        where: ir.individual_id == ^individual_id,
        where: ir.responsability_id == ^responsability_id

    Repo.exists?(query)
  end
end
