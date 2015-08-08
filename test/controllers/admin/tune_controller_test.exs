defmodule Fakebook.Admin.TuneControllerTest do
  use Fakebook.ConnCase

  test "GET /" do
    conn = get conn(), "/admin/tunes"
    assert html_response(conn, 200) =~ "Tunes"
  end

  test "GET / assigns all tunes" do
    tune = %Fakebook.Tune {name: "Morven's March"}
    Repo.insert!(tune)

    expected_tunes = Repo.all(Fakebook.Tune)

    conn = get conn(), "/admin/tunes"
    assert conn.assigns[:tunes] == expected_tunes
  end

  test "GET /new renders the new template" do
    conn = get conn(), "/admin/tunes/new"
    assert html_response(conn, 200) =~ "New Tune"
  end

  test "GET /new sets up a tune changeset" do
    conn = get conn(), "/admin/tunes/new"
    assert conn.assigns[:changeset] == Fakebook.Tune.changeset(%Fakebook.Tune{})
  end
end
