defmodule Fakebook.Admin.TuneControllerTest do
  use Fakebook.ConnCase

  @valid_attrs %{name: "Morven's March"}
  @invalid_attrs %{}

  # index
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

  # new
  test "GET /new renders the new template" do
    conn = get conn(), "/admin/tunes/new"
    assert html_response(conn, 200) =~ "New Tune"
  end

  test "GET /new sets up a tune changeset" do
    conn = get conn(), "/admin/tunes/new"
    assert conn.assigns[:changeset] == Fakebook.Tune.changeset(%Fakebook.Tune{})
  end

  # create
  test "POST /admin/tunes renders the new template when invalid data is supplied" do
    conn = post conn(), "/admin/tunes", tune: @invalid_attrs
    assert html_response(conn, 200) =~ "New Tune"
  end

  test "POST /admin/tunes creates resource, redirects, and flashes a message when data is valid" do
    conn = post conn(), "/admin/tunes", tune: @valid_attrs
    assert get_flash(conn, :info) == "Tune created successfully."
    assert redirected_to(conn) == admin_tune_path(conn, :index)
    assert Repo.get_by(Fakebook.Tune, @valid_attrs)
  end

  # edit
  test "GET /admin/tunes/:id/edit renders the edit template" do
    tune = Repo.insert! %Fakebook.Tune{}

    conn = get conn(), admin_tune_path(conn, :edit, tune)
    assert html_response(conn, 200) =~ "Edit Tune"
  end

  test "GET /admin/tunes/:id/edit assigns tune with matching id" do
    %Fakebook.Tune {name: "Morven's March"} |> Repo.insert!
    tune = Repo.get_by(Fakebook.Tune, %{name: "Morven's March"})

    conn = get conn(), admin_tune_path(conn, :edit, tune)
    assert conn.assigns[:tune] == tune
  end

  test "GET /admin/tunes/:id/edit assigns changeset" do
    %Fakebook.Tune {name: "Morven's March"} |> Repo.insert!
    tune = Repo.get_by(Fakebook.Tune, %{name: "Morven's March"})

    conn = get conn(), admin_tune_path(conn, :edit, tune)
    assert conn.assigns[:changeset] == Fakebook.Tune.changeset(tune)
  end

end
