defmodule ApiWeb.Schema.ItemTypesTest do
  use ApiWeb.ConnCase, async: true

  @query """
  {
    items {
      id
    }
  }
  """
  test "items query returns list of items" do
    conn = build_conn()
    conn = get conn, "/", query: @query
    assert json_response(conn, 200) == %{
      "data" => %{
        "items" => [
          %{"id" => "bar"},
          %{"id" => "buzz"},
          %{"id" => "foo"},
        ]
      }
    }
  end

  @query """
  {
    item(id: "buzz") {
      id
      name
    }
  }
  """
  test "item query returns an item by id" do
    conn = build_conn()
    conn = get conn, "/", query: @query
    assert json_response(conn, 200) == %{
      "data" => %{
        "item" => %{
          "id" => "buzz",
          "name" => "Buzz"
        }
      }
    }
  end
end
