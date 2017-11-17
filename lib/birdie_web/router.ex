defmodule BirdieWeb.Router do
  use BirdieWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BirdieWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/sign_up", RegistrationController, :new
    post "/sign_up", RegistrationController, :create

    get "/chirps", ChirpController, :index #placeholder
  end

  # Other scopes may use custom stacks.
  # scope "/api", BirdieWeb do
  #   pipe_through :api
  # end
end
