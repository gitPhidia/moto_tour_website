defmodule MotoTourWeb.CircuitLive do
  use Phoenix.LiveView
  import Phoenix.HTML
  alias MotoTourWeb.Router.Helpers, as: Routes
  alias MotoTour.Circuits

  def mount(_params, _session, socket) do
    # Assignez le chemin de l'image dans l'état du socket
    circuits = Circuits.list_circuits()
    {:ok, assign(socket, selected_card: "card_1", circuits: circuits, show_card_second: true, card_content: raw("
      <blockquote>
      <i class='fa fa-quote-left fa-xs text-secondary'></i> Circuit sur les pistes des deux lacs en trois jours sera une grande aventure et des difficultés destinées aux enduristes confirmés.<br>
      Prendre la route pour arriver au bord du lac de Tsiazompaniry, le plus grand lac barrage du pays, puis continuer vers l’Est pour visiter le célèbre lac de Mantasoa et le village,<br>
      appréciez chaque instant en découvrant les multiples facettes des hauts plateaux. Pendant ce circuit, vous serez servis par la beauté des paysages naturelles des hautes terres.
      <i class='fa fa-quote-right fa-xs text-secondary'></i>
      </blockquote>
      <p><strong>Destination</strong> :Antananarivo, Antsirabe, Anjozorobe, Ampefy, Mantasoa, Ambatolampy
      <p><strong>Durée</strong> : 6 jours, dont 6 jours de moto, circuit de 900 km</p>
      <p><strong>Participant</strong> :Illimitée personnes max</p>
      <p><strong>Motos recommandées</strong> : KTM 350 – 450</p>
      <p><strong>Région</strong> : Hauts plateaux</p>
      <p><strong>Difficulté</strong> : Moyen à Difficile</p>
      <p><strong>Tarifs</strong> : à partir de 1890 €</p>
      <p><strong>Parcours</strong> : journalier</p>
      <p><strong>Difficultés</strong> : moyen a difficile</p>
      "))
    }
  end

  def handle_event("show_card", %{"card" => card}, socket) do
    {:noreply, assign(socket, :selected_card, card)}
  end

  def handle_event("change_content",  %{"param" => param}, socket) do
    second_card_content = "<blockquote>
              <i class='fa fa-quote-left fa-xs text-secondary'></i> circuit sur les pistes des deux lacs en trois jours sera une grande aventure et des difficultés destinées aux enduristes confirmés.<br>
                Prendre la route pour arriver au bord du lac de Tsiazompaniry, le plus grand lac barrage du pays, puis continuer vers l’Est pour visiter le célèbre lac de Mantasoa et le village,<br>
                appréciez chaque instant en découvrant les multiples facettes des hauts plateaux. Pendant ce circuit, vous serez servis par la beauté des paysages naturelles des hautes terres.
              <i class='fa fa-quote-right fa-xs text-secondary'></i>
            </blockquote>#{param}"
    {:noreply, assign(socket, show_card_second: true, card_content: raw(second_card_content))}
  end

  def render(assigns) do
    ~H"""
     <section class="transition-section py-5">
        <div class="container mt-5">
          <div class="row text-white">
            <!-- Première colonne : Image -->
            <div class="col-md-2 d-flex justify-content-center align-items-center">
              <img src={ Routes.static_path(@socket, "/assets/images/section/logo.png") } alt="Image de transition" class="img-fluid" style="max-width: 100%; height: auto;">
            </div>

            <!-- Deuxième colonne : Texte -->
            <div class="col-md-8 d-flex justify-content-center align-items-center">
              <p class="text-center lead"><h5>"Vivez une nouvelle expérience avec nos parcours inoubliables."</h5></p>
            </div>

          </div>
        </div>
      </section>

      <div class="row">
        <div class="col-md-12 h-50">
          <div class="product-menu text-center d-flex justify-content-center" style="border-bottom: 1px solid #e5e5e5;">
            <nav class="mb-6">
              <ul class="circuitpage">
                <%= for circuit <- @circuits do %>
                  <li><button phx-click="show_card" phx-value-card="card_1" style="font-size:15px;height:3rem;border: 1px solid #e5e5e5;"><h6><strong><%= circuit.nom %></strong></h6></button></li>
                <%= end %>
                  <!-- <li><a phx-click="show_card" phx-value-card="card_2" style="font-size:15px;height:3rem;border: 1px solid #e5e5e5;"><h6><strong>Les 2 lacs en 3 jours</strong></h6></a></li>
                  <li><a phx-click="show_card" phx-value-card="card_3" style="font-size:15px;height:3rem;border: 1px solid #e5e5e5;"><h6><strong>RD 43 en 6 jours</strong></h6></a></li>
                  <li><a phx-click="show_card" phx-value-card="card_4" style="font-size:15px;height:3rem;border: 1px solid #e5e5e5;"><h6><strong>RD 43 en 3 jours</strong></h6></a></li>
                  <li><a phx-click="show_card" phx-value-card="card_5" style="font-size:15px;height:3rem;border: 1px solid #e5e5e5;"><h6><strong>Le sud sauvage</strong></h6></a></li>
                  <li><a phx-click="show_card" phx-value-card="card_6" style="font-size:15px;height:3rem;border: 1px solid #e5e5e5;"><h6><strong>La piste des baobabs</strong></h6></a></li> -->
              </ul>
            </nav>
          </div>
        </div>
      </div>
      <%= render_card(assigns) %>

      <script>
        // Initialisation de l'index
        let currentIndex = 0;
        const items = document.querySelectorAll('.carousel-item');

        // Fonction pour changer d'image
        function moveCarousel(direction) {
          // Enlève la classe active de l'image actuelle
          items[currentIndex].classList.remove('active');

          // Calcule le nouvel index
          currentIndex = (currentIndex + direction + items.length) % items.length;

          // Ajoute la classe active à la nouvelle image
          items[currentIndex].classList.add('active');
        }
      </script>

    """
  end

  def render_card(%{selected_card: "card_1"} = assigns) do
    ~H"""
      <div class="container w-100">
        <div class="row">
            <h4 class="text-start">Les trois lacs en 6 jours</h4>
            <!-- <div class="vc_empty_space" style="height: 30px">
              <span class="vc_empty_space_inner"></span>
            </div> -->
          <!-- Image -->
          <div class="col-lg-4 col-md-12">
            <div class="container_image d-flex justify-content-end">
              <div class="carousel-inner">
                <div id="carousel-item-1" class="carousel-item active">
                  <img src={Routes.static_path(@socket, "/assets/images/section/1.jpg")} class="d-block w-100" alt="Image 1">
                </div>
                <div id="carousel-item-2" class="carousel-item">
                  <img src={Routes.static_path(@socket, "/assets/images/section/2.jpg")} class="d-block w-100" alt="Image 2">
                </div>
                <div id="carousel-item-3" class="carousel-item">
                  <img src={Routes.static_path(@socket, "/assets/images/section/3.jpg")} class="d-block w-100" alt="Image 3">
                </div>
                <button class="carousel-control-prev" type="button" onclick="moveCarousel(-1)">
                  <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                  <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" onclick="moveCarousel(+1)">
                  <span class="carousel-control-next-icon" aria-hidden="true"></span>
                  <span class="visually-hidden">Next</span>
                </button>
              </div>
            </div>

              <div class="text-center mt-3 position-relative d-flex justify-content-md-center">
                <a href="#" class="btn btn-responsive" style="background-color: orange; color: white;">Réserver ce circuit</a>
              </div>
            <div class="vc_empty_space" style="height: 30px">
              <span class="vc_empty_space_inner"></span>
            </div>
          </div>
          <!-- Texte -->
          <div class="col-lg-7 col-md-12 mb-4">
            <div class="product-menu text-center">
              <nav>
                  <ul class="circuitpage">
                    <li><button phx-click="change_content" phx-value-param="
                      <p><strong>Destination</strong> :Antananarivo, Antsirabe, Anjozorobe, Ampefy, Mantasoa, Ambatolampy
                      <p><strong>Durée</strong> : 6 jours, dont 6 jours de moto, circuit de 900 km</p>
                      <p><strong>Participant</strong> :Illimitée personnes max</p>
                      <p><strong>Motos recommandées</strong> : KTM 350 – 450</p>
                      <p><strong>Région</strong> : Hauts plateaux</p>
                      <p><strong>Difficulté</strong> : Moyen à Difficile</p>
                      <p><strong>Tarifs</strong> : à partir de 1890 €</p>
                      <p><strong>Parcours</strong> : journalier</p>
                      <p><strong>Difficultés</strong> : moyen a difficile</p>"
                      style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-map"></i><br><strong>Destination</strong></button></li>
                    <li><button phx-click="change_content" phx-value-param="
                      <div id='accordion'>
                        <div class='card'>
                          <div class='card-header' id='headingOne'>
                              <div class='row'>
                                <div class='col-md-11'>
                                  <a data-toggle='collapse' data-target='#collapseOne' aria-expanded='true' aria-controls='collapseOne'>
                                    <h6 class='mb-0'>
                                      jour 0: Antananarivo
                                    </h6>
                                  </a>
                                </div>
                                <div class='col-md-1 mt-1'>
                                  <a data-toggle='collapse' data-target='#collapseOne' aria-expanded='true' aria-controls='collapseOne'>
                                    <i class='fa fa-angle-down' aria-hidden='true'></i>
                                  </a>
                                </div>
                              </div>

                            <div id='collapseOne' class='collapse' aria-labelledby='headingOne' data-parent='#accordion'>
                              <div class='card-body'>
                                A votre arrivée à l’aéroport international d’Ivato, vous êtes accueillis et conduits directement à votre hôtel.
                              </div>
                            </div>
                          </div>
                        </div>

                        <div class='card'>
                          <div class='card-header' id='headingOne'>
                            <div class='row'>
                              <div class='col-md-11'>
                                <a data-toggle='collapse' data-target='#collapseTwo' aria-expanded='false' aria-controls='collapseTwo'>
                                    <h6 class='mb-0'>
                                        jour 1: Antananarivo-Ampefy
                                    </h6>
                                </a>
                              </div>
                              <div class='col-md-1 mt-1'>
                                <a data-toggle='collapse' data-target='#collapseTwo' aria-expanded='false' aria-controls='collapseTwo'>
                                  <i class='fa fa-angle-down' aria-hidden='true'></i>
                                </a>
                              </div>
                            </div>

                            <div id='collapseTwo' class='collapse' aria-labelledby='headingTwo' data-parent='#accordion'>
                              <div class='card-body'>
                                Vous partirez de bonne heure de la capitale pour rejoindre le centre de Madagascar. Vous découvrirez les pistes environnant les hauts plateaux, et vous arriverez à Ampefy. Découvrez le lac Itasy ainsi que les sentiers volcaniques de la région.
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    " style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-road"></i><br><strong>Itinéraire</strong></button></li>
                    <li><button phx-click="change_content" phx-value-param="parametre_personnalise_5" style="font-size:15px;height:5rem;width:9rem"><i class="fas fa-map-marker-alt"></i><br><strong>sites marquants</strong></button></li>
                    <li><button phx-click="change_content" phx-value-param="parametre_personnalise_2" style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-question"></i><br><strong>Questions</strong></button></li>
                    <li><button phx-click="change_content" phx-value-param="parametre_personnalise_3" style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-comment"></i><br><strong>Avis</strong></button></li>
                  </ul>
              </nav>
            </div>
            <div class="row mr-4" style="margin-top:5%" phx-show={@show_card_second}>
              <p>
                <%= @card_content %>
              </p>
            </div>
          </div>
        </div>
        <div class="row">
        <div class="col-lg-6">
        </div>
        </div>
      </div>

    """
  end

  def render_card(%{selected_card: "card_2"} = assigns) do
    ~H"""
      <div class="container">
        <div class="row">
            <h4>Les 2 lacs en 3 jours</h4>
          <!-- Image -->
          <div class="col-lg-5 col-md-12">
            <img src={Routes.static_path(@socket, "/assets/images/section/2.jpg")} class="img-fluid rounded w-100">
            <blockquote>
              <i class="fa fa-quote-left fa-xs text-secondary"></i> circuit sur les pistes des deux lacs en trois jours sera une grande aventure et des difficultés destinées aux enduristes confirmés.<br>
                Prendre la route pour arriver au bord du lac de Tsiazompaniry, le plus grand lac barrage du pays, puis continuer vers l’Est pour visiter le célèbre lac de Mantasoa et le village,<br>
                appréciez chaque instant en découvrant les multiples facettes des hauts plateaux. Pendant ce circuit, vous serez servis par la beauté des paysages naturelles des hautes terres.
              <i class="fa fa-quote-right fa-xs text-secondary"></i>
            </blockquote>
          </div>
          <!-- Texte -->
          <div class="col-lg-7 col-md-12 mb-4">
            <div class="product-menu text-center">
                <nav>
                    <ul class="circuitpage">
                        <li><button phx-click="toggle_info" style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-map"></i><br><strong>Destination</strong></button></li>
                        <li><button phx-click="toggle_info" style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-euro"></i><br><strong>Tarifs</strong></button></li>
                        <li><button phx-click="toggle_info" style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-clock"></i><br><strong>Durée</strong></button></li>
                        <li><button phx-click="toggle_info" style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-road"></i><br><strong>Itinéraire</strong></button></li>
                        <li><button phx-click="toggle_info" style="font-size:15px;height:5rem;width:9rem"><i class="fas fa-map-marker-alt"></i><br><strong>Sites marquants</strong></button></li>
                    </ul>
                </nav>
            </div>
          </div>
        </div>
        <div class="row">
        <div class="col-lg-6">
        </div>
          <div class="col-lg-6">
            <div class="text-center mt-3">
              <a href="#" class="btn" style="background-color: orange; color: white;">Reserver ce circuit</a>
            </div>
          </div>
        </div>
      </div>

    """
  end

  def render_card(%{selected_card: "card_3"} = assigns) do
    ~H"""
      <div class="container">
        <div class="row">
            <h4>RD 43 en 6 jours</h4>
          <!-- Image -->
          <div class="col-lg-5 col-md-12">
            <img src={Routes.static_path(@socket, "/assets/images/section/4.jpg")} class="img-fluid rounded w-100">
            <blockquote>
              <i class="fa fa-quote-left fa-xs text-secondary"></i>Les hautes terres centrales à votre portée : explorez les hauts plateaux en effectuant le parcours RD 43 en 6 jours. Sur plusieurs kilomètres, les pistes techniques et les zones montagneuses des hauts plateaux vous attendent. Profiter également de ce moment de découverte historique et culturelle, et admirez au guidon de votre moto la beauté de la nature et des paysages. Ne manquez surtout pas de goûter aux spécialités culinaires malgaches en arrivant dans les villes et villages du parcours.
              <i class="fa fa-quote-right fa-xs text-secondary"></i>
            </blockquote>
          </div>
          <!-- Texte -->
          <div class="col-lg-7 col-md-12 mb-4">
            <div class="product-menu text-center">
                <nav>
                    <ul class="circuitpage">
                        <li><button phx-click="toggle_info" style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-map"></i><br><strong>Destination</strong></button></li>
                        <li><button phx-click="toggle_info" style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-euro"></i><br><strong>Tarifs</strong></button></li>
                        <li><button phx-click="toggle_info" style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-clock"></i><br><strong>Durée</strong></button></li>
                        <li><button phx-click="toggle_info" style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-road"></i><br><strong>Itinéraire</strong></button></li>
                        <li><button phx-click="toggle_info" style="font-size:15px;height:5rem;width:9rem"><i class="fas fa-map-marker-alt"></i><br><strong>Sites marquants</strong></button></li>
                    </ul>
                </nav>
            </div>
          </div>
        </div>
        <div class="row">
        <div class="col-lg-6">
        </div>
          <div class="col-lg-6">
            <div class="text-center mt-3">
              <a href="#" class="btn" style="background-color: orange; color: white;">Reserver ce circuit</a>
            </div>
          </div>
        </div>
      </div>

    """
  end

  def render_card(%{selected_card: "card_4"} = assigns) do
    ~H"""
      <div class="container">
        <div class="row">
            <h4>RD 43 en 3 jours</h4>
          <!-- Image -->
          <div class="col-lg-5 col-md-12">
            <img src={Routes.static_path(@socket, "/assets/images/section/5.jpg")} class="img-fluid rounded w-100">
            <blockquote>
              <i class="fa fa-quote-left fa-xs text-secondary"></i>Arpentez les hauts plateaux avec ce parcours de seulement 3 jours qui vous mènera d’Est en Ouest.Dédié aux enduristes confirmé, partez à la découverte de Mantasoa et de son village historique, tout en appréciant le paysage longeant la route.Découvrez les diverses animations locales et faites des rencontres tout au long du parcours, une harmonie de grande aventure et découverte.
              <i class="fa fa-quote-right fa-xs text-secondary"></i>
            </blockquote>
          </div>
          <!-- Texte -->
          <div class="col-lg-7 col-md-12 mb-4">
            <div class="product-menu text-center">
                <nav>
                    <ul class="circuitpage">
                        <li><button phx-click="toggle_info" style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-map"></i><br><strong>Destination</strong></button></li>
                        <li><button phx-click="toggle_info" style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-euro"></i><br><strong>Tarifs</strong></button></li>
                        <li><button phx-click="toggle_info" style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-clock"></i><br><strong>Durée</strong></button></li>
                        <li><button phx-click="toggle_info" style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-road"></i><br><strong>Itinéraire</strong></button></li>
                        <li><button phx-click="toggle_info" style="font-size:15px;height:5rem;width:9rem"><i class="fas fa-map-marker-alt"></i><br><strong>Sites marquants</strong></button></li>
                    </ul>
                </nav>
            </div>
          </div>
        </div>
        <div class="row">
        <div class="col-lg-6">
        </div>
          <div class="col-lg-6">
            <div class="text-center mt-3">
              <a href="#" class="btn" style="background-color: orange; color: white;">Reserver ce circuit</a>
            </div>
          </div>
        </div>
      </div>

    """
  end

  def render_card(%{selected_card: "card_5"} = assigns) do
    ~H"""
      <div class="container">
        <div class="row">
            <h4>Le sud sauvage</h4>
          <!-- Image -->
          <div class="col-lg-5 col-md-12">
            <img src={Routes.static_path(@socket, "/assets/images/section/3.jpg")} class="img-fluid rounded w-100">
            <blockquote>
              <i class="fa fa-quote-left fa-xs text-secondary"></i> Le <strong>Sud de Madagascar</strong> s’offre à vous : entre ciel et mer, au milieu d’un paysage de bush et de sable semi-désertique, vous découvrirez une culture et une nature à nul autre pareil. Cette descente progressive depuis les <strong>hautes terres</strong> jusqu’aux <strong>côtes de l’est</strong> vous permettra d’apprécier une multitude de paysages et de types de piste : sable, terre, boue ponctueront un parcours difficile mais somptueux.
              <i class="fa fa-quote-right fa-xs text-secondary"></i>
            </blockquote>
          </div>
          <!-- Texte -->
          <div class="col-lg-7 col-md-12 mb-4">
            <div class="product-menu text-center">
                <nav>
                    <ul class="circuitpage">
                        <li><button phx-click="toggle_info" style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-map"></i><br><strong>Destination</strong></button></li>
                        <li><button phx-click="toggle_info" style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-euro"></i><br><strong>Tarifs</strong></button></li>
                        <li><button phx-click="toggle_info" style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-clock"></i><br><strong>Durée</strong></button></li>
                        <li><button phx-click="toggle_info" style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-road"></i><br><strong>Itinéraire</strong></button></li>
                        <li><button phx-click="toggle_info" style="font-size:15px;height:5rem;width:9rem"><i class="fas fa-map-marker-alt"></i><br><strong>Sites marquants</strong></button></li>
                    </ul>
                </nav>
            </div>
          </div>
        </div>
        <div class="row">
        <div class="col-lg-6">
        </div>
          <div class="col-lg-6">
            <div class="text-center mt-3">
              <a href="#" class="btn" style="background-color: orange; color: white;">Reserver ce circuit</a>
            </div>
          </div>
        </div>
      </div>

    """
  end

  def render_card(%{selected_card: "card_6"} = assigns) do
    ~H"""
      <div class="container">
        <div class="row">
            <h4>La piste des Baobabs</h4>
          <!-- Image -->
          <div class="col-lg-5 col-md-12">
            <img src={Routes.static_path(@socket, "/assets/images/section/6.jpg")} class="img-fluid rounded w-100">
            <blockquote>
              <i class="fa fa-quote-left fa-xs text-secondary"></i> Bienvenue à Madagascar. Nous réservons ce périple de 9 jours aux motards ayant déjà une expérience de la moto tout-terrain. Aucune notion de vitesse dans nos circuits, mais il faut être d’esprit sportif, et avoir un minimum de technique pour apprécier en toute sécurité la piste et les paysages traversés. La variété hors normes de ce parcours Enduro qui part de la capitale Antananarivo située dans les hauts-plateaux, jusqu’aux pistes côtières longeant le Canal du Mozambique, justifie les efforts quotidiens. Beau mais pas facile, il faut gérer sur la longueur du circuit les pistes de latérite rouge, tantot dur comme du béton, tantot patinoire si la pluie se mêle de la partie, et les pistes de sables qui réclament un peu de technique. C’est ce circuit qui est à l’origine de l’Aventure Malgache qui continue depuis 25 ans…
              <i class="fa fa-quote-right fa-xs text-secondary"></i>
            </blockquote>
          </div>
          <!-- Texte -->
          <div class="col-lg-7 col-md-12 mb-4">
            <div class="product-menu text-center">
                <nav>
                    <ul class="circuitpage">
                      <li><button phx-click="toggle_info" style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-map"></i><br><strong>Destination</strong></button></li>
                      <li><button phx-click="toggle_info" style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-euro"></i><br><strong>Tarifs</strong></button></li>
                      <li><button phx-click="toggle_info" style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-clock"></i><br><strong>Durée</strong></button></li>
                      <li><button phx-click="toggle_info" style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-road"></i><br><strong>Itinéraire</strong></button></li>
                      <li><button phx-click="toggle_info" style="font-size:15px;height:5rem;width:9rem"><i class="fas fa-map-marker-alt"></i><br><strong>Sites marquants</strong></button></li>
                    </ul>
                </nav>
            </div>
          </div>
        </div>
        <div class="row">
        <div class="col-lg-6">
        </div>
          <div class="col-lg-6">
            <div class="text-center mt-3">
              <a href="#" class="btn" style="background-color: orange; color: white;">Reserver ce circuit</a>
            </div>
          </div>
        </div>
      </div>

    """
  end

end
