defmodule Fakebook.TuneController do
  use Fakebook.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
