defmodule MotoTourWeb.CircuitLive do
  use Phoenix.LiveView
  alias MotoTourWeb.Router.Helpers, as: Routes

  def mount(_params, _session, socket) do
    # Assignez le chemin de l'image dans l'état du socket
    {:ok, assign(socket, :selected_card, "card_1")}
  end

  def handle_event("show_card", %{"card" => card}, socket) do
    {:noreply, assign(socket, :selected_card, card)}
  end

  def render(assigns) do
    ~H"""
      <section class="hero-section bg-primary text-white mb-5" style="background-size: cover; background-position: center; background-repeat: no-repeat; height: 100vh; color: white;background-attachment: fixed;"}>

      <div class="container-fluid d-flex align-items-center justify-content-center text-start" style="height: 100vh;">
        <div style="margin-top: 250px;"> <!-- Ajout d'un margin-top ici -->
          <h1 class="display-4 mb-4">Bienvenue à Moto Parcours</h1>
          <p class="lead">Des pistes surprenantes, des paysages somptueux,<br> hors du temps et une hospitalité toujours bienveillante.<br> Après 30 ans à sillonner la grande île, c’est toujours avec un grand plaisir que j’accompagne les motards <br> les plus expérimentés comme les novices sur les chemins connus et moins connus de Madagascar.</p>
          <p class="text-end"><i class="fa fa-quote-right fa-xs text-secondary"></i> <strong> François Serrano </strong> </p>

        </div>
      </div>
      </section>

      <div class="row">
        <div class="col-md-12">
          <div class="product-menu text-center">
            <nav>
              <ul class="circuitpage">
                <li><button phx-click="show_card" phx-value-card="card_1" style="font-size:15px;height:3rem"><strong>Les trois lacs en 6 jours</strong></button></li>
                <li><button phx-click="show_card" phx-value-card="card_2" style="font-size:15px;height:3rem"><strong>Les 2 lacs en 3 jours</strong></button></li>
                <li><button phx-click="show_card" phx-value-card="card_3" style="font-size:15px;height:3rem"><strong>RD 43 en 6 jours</strong></button></li>
                <li><button phx-click="show_card" phx-value-card="card_4" style="font-size:15px;height:3rem"><strong>RD 43 en 3 jours</strong></button></li>
                <li><button phx-click="show_card" phx-value-card="card_5" style="font-size:15px;height:3rem"><strong>Le sud sauvage</strong></button></li>
                <li><button phx-click="show_card" phx-value-card="card_6" style="font-size:15px;height:3rem"><strong>La piste des baobabs</strong></button></li>
              </ul>
            </nav>
          </div>
        </div>
      </div>
      <%= render_card(assigns) %>
    """
  end

  def render_card(%{selected_card: "card_1"} = assigns) do
    ~H"""
      <div class="container">
        <div class="row">
            <h4>Les trois lacs en 6 jours</h4>
          <!-- Image -->
          <div class="col-lg-5 col-md-12">
            <img src={Routes.static_path(@socket, "/assets/images/section/1.jpg")} class="img-fluid rounded w-100">
            <blockquote>
              <i class="fa fa-quote-left fa-xs text-secondary"></i> En quête d’aventure, sillonner les toits de Madagascar avec cet enduro de 6 jours sur les pistes des trois lacs. Ce parcours autour des hauts plateaux vous réservera : plusieurs kilomètres de routes, pistes, terres et boues. En partant de la capitale, découvrez la végétation le long de la RN2. Faites des rencontres avec la population aussi hospitalière, et découvrez les spécialités culinaires locales. Surtout, sur votre moto, profitez des magnifiques paysages, des rizières, cultures en terrasse et de la vue sur les sentiers volcaniques d’Ampefy.
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
