defmodule Fakebook.TuneController do
  use Fakebook.Web, :controller

  def index(conn, _params) do
    render conn, "index.html",
     tunes: Repo.all(Fakebook.Tune)
  end

  def show(conn, %{"id" => id}) do
    tune = Repo.get(Fakebook.Tune, id)
    render(conn, :show, tune: tune)
  end
end
