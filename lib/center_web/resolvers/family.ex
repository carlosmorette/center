defmodule CenterWeb.Resolvers.Family do
  def find(id, _resolution) do
    case Center.Schemas.Family.find(id: id) do
      nil ->
        {:error,
         %{
           reason: :not_found,
           message: "Família não encontrada"
         }}

      record ->
        {:ok, format(record)}
    end
  end

  def format(record, encode_id \\ false) do
    id =
      if encode_id do
        Absinthe.Relay.Node.to_global_id("Family", record.id)
      else
        record.id
      end

    %CenterWeb.Family{
      id: id,
      name: record.name
    }
  end

  def create(_parent, args, _resolution) do
    case Center.Schemas.Family.create(args) do
      {:ok, record} ->
        {:ok, format(record, true)}

      {:error, error} ->
        {:error, inspect(error)}
    end
  end

  def find_all(_params, _resolution) do
    {:ok,
     Center.Schemas.Family.find_all()
     |> Enum.map(fn r -> format(r, true) end)}
  end
end
