defmodule Fakebook.TuneControllerTest do
  use Fakebook.ConnCase

  test "GET /" do
    conn = get conn(), "/tunes"
    assert html_response(conn, 200) =~ "Tunes"
  end
end
