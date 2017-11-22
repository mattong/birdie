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

    get "/", PageController, :index

    resources "/sign_up", RegistrationController, only: [:new, :create]

    resources "/sign_in", SessionController, only: [:new, :create, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", BirdieWeb do
  #   pipe_through :api
  # end
end
