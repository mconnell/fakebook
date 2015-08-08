defmodule Fakebook.Admin.TuneController do
  use Fakebook.Web, :controller

  alias Fakebook.Tune

  def index(conn, _params) do
    render conn, "index.html",
      tunes: Repo.all(Tune)
  end

  def new(conn, _params) do
    render conn, "new.html",
      changeset: Tune.changeset(%Tune{})
  end

 def create(conn, %{"tune" => tune_params}) do
    changeset = Tune.changeset(%Tune{}, tune_params)

    if changeset.valid? do
      Repo.insert!(changeset)
      conn
      |> put_flash(:info, "Tune created successfully.")
      |> redirect(to: admin_tune_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    tune = Repo.get(Tune, id)
    render conn, "edit.html",
      tune: tune,
      changeset: Tune.changeset(tune)
  end
end
