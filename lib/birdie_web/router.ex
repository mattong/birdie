defmodule BirdieWeb.Router do
  use BirdieWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Birdie.Plug.Auth, repo: Birdie.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BirdieWeb do
    pipe_through :browser # Use the default browser stack

    get "/dashboard", PageController, :index
    post "/dashboard", ChirpController, :chirp

    get "/sign_up", RegistrationController, :new
    post "/sign_up", RegistrationController, :create

    get "/", SessionController, :new
    post "/", SessionController, :create

    delete "/sign_out", SessionController, :delete

    resources "/users", UserController
  end
end

defmodule UserController do
  use BirdieWeb, :controller
end
