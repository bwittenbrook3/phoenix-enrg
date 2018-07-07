defmodule ApiWeb.Schema do
  use Absinthe.Schema

  import_types ApiWeb.Schema.ItemTypes

  query do
    import_fields :item_queries
  end

end
