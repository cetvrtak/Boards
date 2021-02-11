defmodule VisionWeb.Router do
  use VisionWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {VisionWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", VisionWeb do
    pipe_through :browser

    live "/", PageLive, :index
  end

  scope "/", VisionWeb do
    pipe_through [:browser, :protected]

    live "/boards", BoardLive.Index, :index
    live "/boards/new", BoardLive.Index, :new
    live "/boards/:id/edit", BoardLive.Index, :edit

    live "/boards/:id", BoardLive.Show, :show
    live "/boards/:id/show/edit", BoardLive.Show, :edit
  end

  scope "/", VisionWeb do
    pipe_through [:browser, :protected]

    live "/members", MemberLive.Index, :index
    live "/members/new", MemberLive.Index, :new
    live "/members/:id/edit", MemberLive.Index, :edit

    live "/members/:id", MemberLive.Show, :show
    live "/members/:id/show/edit", MemberLive.Show, :edit  
  end

  scope "/", VisionWeb do
    pipe_through [:browser, :protected]

    live "/lists", ListLive.Index, :index
    live "/lists/new", ListLive.Index, :new
    live "/lists/:id/edit", ListLive.Index, :edit

    live "/lists/:id", ListLive.Show, :show
    live "/lists/:id/show/edit", ListLive.Show, :edit

    live "/lists/tasks/new", TaskLive.Index, :new
  end

  # Other scopes may use custom stacks.
  # scope "/api", VisionWeb do
  #   pipe_through :api
  # end

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
      live_dashboard "/dashboard", metrics: VisionWeb.Telemetry
    end
  end
end
