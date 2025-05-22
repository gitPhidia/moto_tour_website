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

  pipeline :circuit do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {MotoTourWeb.LayoutView, :rootcircuit}
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
    get "/propos", PageController, :propos
    get "/robots.txt", PageController, :robots
    # resources "/question", QuestionsController, only: [:new, :create]
    get "/sitemap.xml", PageController, :sitemap

  end

  scope "/", MotoTourWeb do
    pipe_through :circuit

    live "/circuit", CircuitLive
    live "/circuit/:id", CircuitLive
    live "/videolive", VideoLive
    resources "/question", QuestionsController, only: [:new, :create]
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
    get "/admin/menu", PageController, :bcircuit
    get "/admin/ajout_circuit", CircuitsController, :ajoutc
    post "/admin/save_circuit", CircuitsController, :create
    get "/admin/edit/:id", CircuitsController, :edit
    put "/admin/update/:id", CircuitsController, :update
    delete "/admin/delete/:id", CircuitsController, :delete
    get "/admin/deshboard", CircuitsController, :deshboard
    get "/admin/update-archive/:id", CircuitsController, :archiver

    # reservation
    get "/admin/index", ReservationController, :index

    # itineraire
    get "/admin/itineraire/:id", ItineraireController, :liste
    get "/admin/itineraire", ItineraireController, :index
    get "/admin/itineraire_edit/:id", ItineraireController, :edit
    get "/admin/itineraire_ajout/:id", ItineraireController, :ajout
    post "/admin/itineraire_create", ItineraireController, :create
    put "/admin/itineraire_up/:id", ItineraireController, :update
    delete "/admin/itineraire_del/:id", ItineraireController, :delete
    live "/admin/newitineraire/:id", AjoutLive
    live "/admin/edititineraire/:id", EditLive

    # photo
    # resources "/photo", PhotoController, [:new, :create, :index, :show, :edit, :delete, :update]
    get "/admin/photo/:id", PhotoController, :detail
    get "/admin/photo_new/:id", PhotoController, :new
    post "/admin/save_photo", PhotoController, :create
    get "/admin/index_photo", PhotoController, :index
    get "/admin/photo_show/:id", PhotoController, :show
    get "/admin/phoot_edit/:id", PhotoController, :edit
    put "/admin/photo_maj", PhotoController, :update
    delete "/admin/photo_del/:id", PhotoController, :delete
    post "/admin/update-checkboxes", PhotoController, :principal

    # resources "/question", QuestionsController, only: [:index, :show, :edit, :delete, :update]
    resources "/admin/question", QuestionsController, only: [:index, :show, :edit, :delete, :update]
    get "/admin/question_index/:page", QuestionsController, :index_page

    get "/admin/circuit_enduro", PageController, :bcircuit
    get "/admin/users/settings", UserSettingsController, :edit
    put "/admin/users/settings", UserSettingsController, :update
    get "/admin/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
    get "/admin/users/register", UserRegistrationController, :new
    post "/admin/users/register", UserRegistrationController, :create
    get "/admin/users/reset_password", UserResetPasswordController, :new
    post "/admin/users/reset_password", UserResetPasswordController, :create
    get "/admin/users/reset_password/:token", UserResetPasswordController, :edit
    put "/admin/users/reset_password/:token", UserResetPasswordController, :update

    live "/admin/tarif/:id", TarifLive
    get "/admin/prestation/:id", TarifController, :edit
    put "/admin/prestation_up/:id", TarifController, :update

    get "/admin/nonprestation/:id", NontarifController, :edit
    put "/admin/nonprestation_up/:id", NontarifController, :update

    get "/admin/video/ajout", VideosController, :ajout
    post "/admin/video/create", VideosController, :create
    post "/admin/video/update-checkboxes", VideosController, :principal
    get "/admin/video_del/:id", VideosController, :supprimer
    get "/admin/video_edit/:id", VideosController, :edit
    put "/admin/video_update/:id", VideosController, :update
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
