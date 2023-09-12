defmodule MultiGameWeb.ErrorJSONTest do
  use MultiGameWeb.ConnCase, async: true

  test "renders 404" do
    assert MultiGameWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert MultiGameWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
