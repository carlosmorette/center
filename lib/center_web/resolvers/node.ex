defmodule CenterWeb.Resolvers.Node do
  def find(%{type: :family, id: id}, resolution) do
    CenterWeb.Resolvers.Family.find(id, resolution)
  end
end
