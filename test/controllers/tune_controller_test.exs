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

  test "GET /tune/:id renders ok" do
    %Fakebook.Tune {name: "Morven's March"} |> Repo.insert!
    tune = Repo.get_by(Fakebook.Tune, %{name: "Morven's March"})

    conn = conn()
    |> get tune_path(conn, :show, tune)

    assert html_response(conn, 200) =~ "Morven&#39;s March"
    assert conn.assigns[:tune] == tune
  end

  test "GET /api/xml/tune/:id renders music_xml" do
    %Fakebook.Tune {name: "Morven's March", music_xml: "xml content"} |> Repo.insert!
    tune = Repo.get_by(Fakebook.Tune, %{name: "Morven's March"})

    conn = conn()
    |> get xml_api_tune_path(conn, :show, tune)

    assert response(conn, 200) =~ "xml content"
    assert conn.assigns[:tune] == tune
  end
end
