defmodule TwinklyhahaWeb.Router do
  use TwinklyhahaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TwinklyhahaWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    # plug :accepts, ["json"]
    plug :accepts, ["application/openc2-cmd+json;version=1.0"]
  end

  scope "/", TwinklyhahaWeb do
    pipe_through :browser

    live "/", PageLive, :index
    live "/phoenix", PageLive, :index
    live "/twinkly", TwinklyLive, :twinkly
  end

  # Other scopes may use custom stacks.
  # scope "/api", TwinklyhahaWeb do
  #   pipe_through :api
  # end

  scope "/openc2", TwinklyhahaWeb do
    pipe_through :api
    post "/", OC2Controller, :command
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: TwinklyhahaWeb.Telemetry
    end
  end
end
