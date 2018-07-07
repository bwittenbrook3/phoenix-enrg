defmodule ApiWeb.Schema.ItemTypes do
  use Absinthe.Schema.Notation

  alias ApiWeb.Resolvers.Items

  @desc "An example of some cool object"
  object :item do
    field :id, :id
    field :name, :string
  end

  object :item_queries do

    @desc "Get an item"
    field :item, :item do
      arg :id, non_null(:id)
      resolve &Items.find_item/3
    end

    @desc "Get all items"
    field :items, list_of(:item) do
      resolve &Items.find_items/3
    end

  end
end
