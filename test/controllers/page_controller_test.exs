defmodule Fakebook.PageControllerTest do
  use Fakebook.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "This is the landing page of the fakebook. Wooo!"
  end
end
