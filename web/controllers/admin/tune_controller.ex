defmodule Fakebook.Admin.TuneController do
  use Fakebook.Web, :controller

  alias Fakebook.Tune

  def index(conn, _params) do
    render conn, "index.html",
      tunes: Repo.all(Tune)
  end

end
