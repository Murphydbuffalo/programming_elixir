defmodule HelloWorld.Router do
  use HelloWorld.Web, :router

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

  scope "/", HelloWorld do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/hello", HelloController, :index
    get "/hello/:message", HelloController, :show

    resources "/users", UserController
    resources "/reviews", ReviewController
  end

  scope "/admin", HelloWorld.Admin, as: :admin do
    pipe_through :browser

    resources "/users", UserController
    resources "/reviews", ReviewController
  end
end
