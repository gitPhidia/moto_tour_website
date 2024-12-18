defmodule MotoTourWeb.Router do
  use MotoTourWeb, :router

  import MotoTourWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {MotoTourWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
    plug Plug.CSRFProtection
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admin do
    plug :accepts, ["html"]
    plug :fetch_live_flash
    plug :put_root_layout, {MotoTourWeb.LayoutView, :menu}
    plug :fetch_session
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  # scope "/admin", MotoTourWeb.Admin do
  #   pipe_through [:browser, :admin]

  #   live "/dashboard", DashboardLive, :index
  # end

  scope "/", MotoTourWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/liste", PageController, :liste
    get "/propos", PageController, :propos
    get "/contact", PageController, :contact
    # Route pour la LiveView Home
    live "/home", HomeLive
    live "/circuit", CircuitLive
    live "/circuit/:id", CircuitLive
    live "/menu_card", MenuCardLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", MotoTourWeb do
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

      live_dashboard "/dashboard", metrics: MotoTourWeb.Telemetry
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

  scope "/", MotoTourWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
  end

  scope "/", MotoTourWeb do
    pipe_through [:browser, :require_authenticated_user, :admin]

    # circuit
    # live "/menu", BackLive
    get "/menu", PageController, :bcircuit
    get "/ajout_circuit", CircuitsController, :ajoutc
    post "/save_circuit", CircuitsController, :create
    get "/edit/:id", CircuitsController, :edit
    put "/update/:id", CircuitsController, :update
    delete "/delete/:id", CircuitsController, :delete
    get "/deshboard", CircuitsController, :deshboard
    get "/update-archive/:id", CircuitsController, :archiver

    # reservation
    get "/index", ReservationController, :index

    # itineraire
    get "/itineraire/:id", ItineraireController, :liste
    get "/itineraire", ItineraireController, :index
    get "/itineraire_edit/:id", ItineraireController, :edit
    get "/itineraire_ajout", ItineraireController, :ajout
    post "/itineraire_create", ItineraireController, :create
    put "/itineraire_up/:id", ItineraireController, :update
    delete "/itineraire_del/:id", ItineraireController, :delete

    # photo
    # resources "/photo", PhotoController, [:new, :create, :index, :show, :edit, :delete, :update]
    get "/photo/:id", PhotoController, :detail
    get "/photo_new", PhotoController, :new
    post "/save_photo", PhotoController, :create
    get "/index_photo", PhotoController, :index
    get "/photo_show/:id", PhotoController, :show
    get "/phoot_edit/:id", PhotoController, :edit
    put "/photo_maj", PhotoController, :update
    delete "/photo_del/:id", PhotoController, :delete
    post "/update-checkboxes", PhotoController, :principal

    resources "/question", QuestionsController, only: [:new, :create, :index, :show, :edit, :delete, :update]
    get "/circuit_enduro", PageController, :bcircuit
    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", MotoTourWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update
  end
end
