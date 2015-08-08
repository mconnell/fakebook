defmodule Fakebook.Router do
  use Fakebook.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :admin_layout do
    plug :put_layout, {Fakebook.LayoutView, :admin}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Fakebook do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/tunes", TuneController, :index
  end

  scope "/admin", as: :admin do
    pipe_through [:browser, :admin_layout]
    resources "/tunes", Fakebook.Admin.TuneController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Fakebook do
  #   pipe_through :api
  # end
end
