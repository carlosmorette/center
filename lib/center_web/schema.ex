defmodule CenterWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern

  node object(:family) do
    field :name, non_null(:string)
  end

  node interface do
    resolve_type(fn
      %CenterWeb.Family{}, _ -> :family
      _, _ -> nil
    end)
  end

  query do
    node field do
      resolve(&CenterWeb.Resolvers.Node.find/2)
    end

    field :family, list_of(:family) do
      resolve(&CenterWeb.Resolvers.Family.find_all/2)
    end
  end

  mutation do
    payload field :create_family do
      input do
        field :name, non_null(:string)
      end

      output do
        field :id, non_null(:id)
      end

      resolve(&CenterWeb.Resolvers.Family.create/3)
    end
  end
end
