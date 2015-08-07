defmodule Fakebook.Admin.TuneController do
  use Fakebook.Web, :controller

  def index(conn, _params) do
    render conn, "index.html",
      tunes: Fakebook.Repo.all(Fakebook.Tune)
  end
end