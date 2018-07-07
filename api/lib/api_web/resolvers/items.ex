defmodule ApiWeb.Resolvers.Items do

  # Example data
  @items %{
    "foo" => %{id: "foo", name: "Foo"},
    "bar" => %{id: "bar", name: "Bar"}
  }

  def find_item(_parent, %{id: id}, _resolution) do
    {:ok, @items[id]}
  end

  def find_items(_parent, %{}, _resolution) do
    {:ok, Map.values(@items)}
  end


end
