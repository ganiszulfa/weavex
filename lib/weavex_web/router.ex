defmodule WeavexWeb.Router do
  use WeavexWeb, :router

  import WeavexWeb.UserAuth
  import WeavexWeb.PageLive.Plug

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {WeavexWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
    plug :fetch_pages
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WeavexWeb do
    pipe_through [:browser]

    live "/", PostLive.IndexPublic, :index_public
    live "/posts/:slug/:id", PostLive.ShowPublic, :show_public

    live "/pages/:slug/:id", PageLive.ShowPublic, :show_public
  end

  scope "/admin", WeavexWeb do
    pipe_through [:browser, :require_authenticated_user]

    live "/posts", PostLive.Index, :index
    live "/posts/new", PostLive.Index, :new
    live "/posts/:id/edit", PostLive.Index, :edit

    live "/posts/:id", PostLive.Show, :show
    live "/posts/:id/show/edit", PostLive.Show, :edit

    live "/pages", PageLive.Index, :index
    live "/pages/new", PageLive.Index, :new
    live "/pages/:id/edit", PageLive.Index, :edit

    live "/pages/:id", PageLive.Show, :show
    live "/pages/:id/show/edit", PageLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", WeavexWeb do
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
      pipe_through [:browser, :require_authenticated_user]

      live_dashboard "/dashboard", metrics: WeavexWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", WeavexWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    if Application.get_env(:weavex, :register?) do
      get "/users/register", UserRegistrationController, :new
      post "/users/register", UserRegistrationController, :create
    end

    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", WeavexWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/", WeavexWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update
  end
end
