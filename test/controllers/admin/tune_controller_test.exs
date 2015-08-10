defmodule Fakebook.Admin.TuneControllerTest do
  use Fakebook.ConnCase

  @valid_attrs %{name: "Morven's March"}
  @invalid_attrs %{}

  @username System.get_env("BASIC_AUTH_NAME")
  @password System.get_env("BASIC_AUTH_PASSWORD")

  defp using_basic_auth(conn, username, password) do
    header_content = "Basic " <> Base.encode64("#{username}:#{password}")
    conn |> put_req_header("authorization", header_content)
  end

  # index
  test "GET /" do
    conn = conn()
      |> using_basic_auth(@username, @password)
      |> get("/admin/tunes")

    assert html_response(conn, 200) =~ "Tunes"
  end

  test "GET / assigns all tunes" do
    tune = %Fakebook.Tune {name: "Morven's March"}
    Repo.insert!(tune)

    expected_tunes = Repo.all(Fakebook.Tune)

    conn = conn()
      |> using_basic_auth(@username, @password)
      |> get("/admin/tunes")

    assert conn.assigns[:tunes] == expected_tunes
  end

  # new
  test "GET /new renders the new template" do
    conn = conn()
      |> using_basic_auth(@username, @password)
      |> get("/admin/tunes/new")

    assert html_response(conn, 200) =~ "New Tune"
  end

  test "GET /new sets up a tune changeset" do
    conn = conn()
      |> using_basic_auth(@username, @password)
      |> get("/admin/tunes/new")

    assert conn.assigns[:changeset] == Fakebook.Tune.changeset(%Fakebook.Tune{})
  end

  # create
  test "POST /admin/tunes renders the new template when invalid data is supplied" do
    conn = conn()
    |> using_basic_auth(@username, @password)
    |> post("/admin/tunes", tune: @invalid_attrs)

    assert html_response(conn, 200) =~ "New Tune"
  end

  test "POST /admin/tunes creates resource, redirects, and flashes a message when data is valid" do
    conn = conn()
    |> using_basic_auth(@username, @password)
    |> post("/admin/tunes", tune: @valid_attrs)

    assert get_flash(conn, :info) == "Tune created successfully."
    assert redirected_to(conn) == admin_tune_path(conn, :index)
    assert Repo.get_by(Fakebook.Tune, @valid_attrs)
  end

  # edit
  test "GET /admin/tunes/:id/edit renders the edit template" do
    tune = Repo.insert! %Fakebook.Tune{}

    conn = conn()
    |> using_basic_auth(@username, @password)
    |> get admin_tune_path(conn, :edit, tune)

    assert html_response(conn, 200) =~ "Edit Tune"
  end

  test "GET /admin/tunes/:id/edit assigns tune with matching id" do
    %Fakebook.Tune {name: "Morven's March"} |> Repo.insert!
    tune = Repo.get_by(Fakebook.Tune, %{name: "Morven's March"})

    conn = conn()
    |> using_basic_auth(@username, @password)
    |> get admin_tune_path(conn, :edit, tune)

    assert conn.assigns[:tune] == tune
  end

  test "GET /admin/tunes/:id/edit assigns changeset" do
    %Fakebook.Tune {name: "Morven's March"} |> Repo.insert!
    tune = Repo.get_by(Fakebook.Tune, %{name: "Morven's March"})

    conn = conn()
    |> using_basic_auth(@username, @password)
    |> get(admin_tune_path(conn, :edit, tune), tune: @invalid_attrs)

    assert conn.assigns[:changeset] == Fakebook.Tune.changeset(tune)
  end

  # update
  test "does not update chosen resource and renders errors when data is invalid" do
    tune = Repo.insert! %Fakebook.Tune{}

    conn = conn()
    |> using_basic_auth(@username, @password)
    |> put(admin_tune_path(conn, :update, tune), tune: @invalid_attrs)

    assert html_response(conn, 200) =~ "Edit Tune"
  end

  test "updates chosen resource and redirects when data is valid" do
    tune = Repo.insert! %Fakebook.Tune{}

    conn = conn()
    |> using_basic_auth(@username, @password)
    |> put(admin_tune_path(conn, :update, tune), tune: @valid_attrs)

    assert get_flash(conn, :info) == "Tune updated successfully."
    assert redirected_to(conn) == admin_tune_path(conn, :index)
    assert Repo.get_by(Fakebook.Tune, @valid_attrs)
  end

  # delete
  test "deletes chosen resource" do
    tune = Repo.insert! %Fakebook.Tune{}

    conn = conn()
    |> using_basic_auth(@username, @password)
    |> delete(admin_tune_path(conn, :delete, tune))

    assert get_flash(conn, :info) == "Tune deleted successfully."
    assert redirected_to(conn) == admin_tune_path(conn, :index)
    refute Repo.get(Fakebook.Tune, tune.id)
  end

end
