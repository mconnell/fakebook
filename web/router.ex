defmodule Fakebook.Router do
  use Fakebook.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :admin do
    plug BasicAuth, realm: "Admin Area",
                    username: Application.get_env(:fakebook, :basic_auth)[:username],
                    password: Application.get_env(:fakebook, :basic_auth)[:password]

    plug :put_layout, {Fakebook.LayoutView, :admin}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :xml_api do
    plug :accepts, ["xml"]
  end

  scope "/", Fakebook do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/tunes", TuneController
  end

  scope "/api/xml/", as: :xml_api, alias: Fakebook do
    pipe_through [:xml_api]
    resources "/tunes", TuneController, only: [:show]
  end

  scope "/admin", as: :admin do
    pipe_through [:admin, :browser]
    resources "/tunes", Fakebook.Admin.TuneController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Fakebook do
  #   pipe_through :api
  # end
end
