defmodule MotoTourWeb.VideoLive do
  use Phoenix.LiveView
  alias MotoTour.Videos

  def mount(_params, _session, socket) do
    videos = Videos.list_Video()
    selected = Videos.principal()
    selected_video =
      case selected do
        [%MotoTour.Video{} = video | _] -> video  # Prend le premier élément si c'est une liste
        video when is_map(video) -> video         # Garde tel quel si c'est déjà une seule vidéo
        _ -> nil                                  # Sinon, retourne nil (aucune vidéo sélectionnée)
      end

    # Filtrer la liste pour exclure la vidéo sélectionnée
    filtered_videos =
      case selected_video do
        nil -> videos  # Si aucune vidéo sélectionnée, ne change rien
        _ -> Enum.reject(videos, fn video -> video.id == selected_video.id end)
      end

    {:ok, assign(socket, videos: filtered_videos, selected_video: selected_video, page_title: "Moto tour Madagascar : Toutes nos vidéos", meta_description: "Découvrez nos vidéos exclusives de Moto Tour Madagascar : des paysages à couper le souffle, des circuits inoubliables et des aventures palpitantes à travers l'île rouge. Vivez l'expérience en images !")}
  end

  def render(assigns) do
    ~H"""
    <style>
    .video-scroll-container {
      max-height: 66vh; /* S'ajuste dynamiquement à la hauteur de l'écran */
      overflow-y: auto;
      padding-right: 10px;
      scroll-behavior: smooth;
    }

    /* Barre de scroll plus discrète */
    .video-scroll-container::-webkit-scrollbar {
      width: 6px;
    }

    .video-scroll-container::-webkit-scrollbar-thumb {
      background: rgba(0, 0, 0, 0.3);
      border-radius: 10px;
    }

    /* Responsive: ajuste la largeur des miniatures */
    .video-item {
      width: 50%;
    }

    /* En mobile: 2 vidéos par ligne */
    @media (max-width: 768px) {
      .video-item {
        width: 48%;
      }
    }

    /* En très petit écran (ex: téléphone en mode portrait) */
    @media (max-width: 480px) {
      .video-scroll-container {
        max-height: 40vh;
      }

      .video-item {
        margin-top: 5%;
        width: 100%; /* 1 vidéo par ligne */
      }
    }
    </style>
    <div class="section px-3 px-md-5">
      <h1 class="text-center mt-3 mt-md-0" style="font-size: clamp(1.5rem, 5vw, 2rem); word-wrap: break-word;">
        Aventures en Moto à Madagascar
      </h1>

      <p class="text-center text-muted">
        Découvrez Madagascar comme jamais auparavant avec une excursion en moto tout-terrain !
        Traversez des paysages spectaculaires, des villages authentiques et vivez une expérience unique.
      </p>

        <!-- Vidéo principale -->
        <div class="row">
          <div class="col-12 col-md-7">
            <div class="ratio ratio-16x9">
              <iframe id="main-video" class="content rounded shadow-sm"
                src={"https://www.youtube.com/embed/#{@selected_video.lien}"} frameborder="0" title={@selected_video.titre}
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                referrerpolicy="strict-origin-when-cross-origin" allowfullscreen>
              </iframe>
            </div>
          </div>

          <!-- Liste des vidéos -->
          <div class="col-12 col-md-5">
            <div class="video-scroll-container">
              <%= for video <- @videos do %>
              <a href="#" phx-click="select_video" phx-value-lien={video.lien} class="text-decoration-none text-dark w-100 d-block mb-3">
                <div class="d-flex flex-row align-items-start">
                  <img src={"https://img.youtube.com/vi/#{video.lien}/0.jpg"}
                      alt={video.titre}
                      class="rounded shadow-sm me-3"
                      style="width: 220px; height: auto; flex-shrink: 0;">
                  <div class="flex-grow-1">
                    <h2 class="mb-1 fw-bold fs-6"><%= video.titre %></h2>
                    <p class="mb-1 fs-6"><%= video.createur %></p>
                    <p class="mb-0 text-muted fs-6"><%= video.duree %> min</p>
                  </div>
                </div>
              </a>
              <% end %>
            </div>
          </div>

        </div>

      </div>
    """
  end

  def handle_event("select_video", %{"lien" => video_lien}, socket) do
    selected_video = Videos.video_select(video_lien)
    videos = Videos.list_Video()

    # Filtrer la liste pour exclure la vidéo sélectionnée
    filtered_videos =
      case selected_video do
        nil -> videos  # Si aucune vidéo sélectionnée, ne change rien
        _ -> Enum.reject(videos, fn video -> video.id == selected_video.id end)
      end

    if selected_video do
      # remaining_videos = Enum.reject( videos, &(&1.lien == video_lien))

      {:noreply, assign(socket, selected_video: selected_video, videos: filtered_videos)}
    else
      {:noreply, socket}
    end
  end

end
