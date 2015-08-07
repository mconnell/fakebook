defmodule Fakebook.TuneControllerTest do
  use Fakebook.ConnCase

  test "GET /" do
    conn = get conn(), "/tunes"
    assert html_response(conn, 200) =~ "Tunes"
  end

  test "GET / assigns all tunes" do
    tune = %Fakebook.Tune {name: "Morven's March"}
    Fakebook.Repo.insert!(tune)

    expected_tunes = Fakebook.Repo.all(Fakebook.Tune)

    conn = get conn(), "/tunes"
    assert conn.assigns[:tunes] == expected_tunes
  end
end
