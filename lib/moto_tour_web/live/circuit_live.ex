defmodule MotoTourWeb.CircuitLive do
  use Phoenix.LiveView
  import Phoenix.HTML
  alias MotoTourWeb.Router.Helpers, as: Routes
  alias MotoTour.Circuits
  alias MotoTour.Itineraires

  def mount(_params, _session, socket) do
    # Assignez le chemin de l'image dans l'état du socket
    circuits = Circuits.list_circuits()
    # prend la premiere enregistrement dans la map de circuits
    first_circuit = List.first(circuits)
    # transorme les resultat en html,voir la foncrion function
    second_card_content_html = function_destination(first_circuit.id)
    {:ok, assign(socket, selected_card: [first_circuit.id], circuit: [first_circuit], circuits: circuits, show_card_second: true, card_content: raw(second_card_content_html))
    }
  end

  # montre la card: l'image et le tab de destination
  def handle_event("show_card", %{"card" => card}, socket) do
    cards= Circuits.single_circuit(card)
    second_card_content_html = function_destination(card)
    {:noreply, assign(socket, selected_card: card, circuit: cards, card_content: raw(second_card_content_html))}
  end

  # montre les contenue du boutton destination
  def handle_event("change_content",  %{"param" => param}, socket) do
    second_card_content = Circuits.single_circuit(param)
    second_card_content_html = function_destination(param)
    {:noreply, assign(socket, show_card_second: true, card_content: raw(second_card_content_html))}
  end

  def handle_event("change_liste",  %{"param" => param}, socket) do
    second_card_content = Circuits.single_circuit(param)
    second_card_content_html = function_itineraire(param)
    {:noreply, assign(socket, show_card_second: true, card_content: raw(second_card_content_html))}
  end

  # concatène les resultats en html
  defp function_itineraire(param) do
    second_card_content = Itineraires.itineraire_circuit(param)
    second_card_content_html =
      for c <- second_card_content do
        """
        <div id='accordion'>
            <div class='card'>
              <div class='card-header' id='headingOne'>
                  <div class='row'>
                    <div class='col-md-11'>
                      <a data-toggle='collapse' data-target='#collapseOne' aria-expanded='true' aria-controls='collapseOne'>
                        <h6 class='mb-0'>
                          #{c.itineraire}
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
                    #{c.remarque}
                  </div>
                </div>
              </div>
            </div>
          </div>
        """
      end
      |> Enum.join("") # Concatène toutes les chaînes en une seule
  end


  # concatène les resultats en html
  defp function_destination(param) do
    second_card_content = Circuits.single_circuit(param)
    second_card_content_html =
      for circuit <- second_card_content do
        """
        <p><strong>Destination</strong> : #{circuit.desc_card}</p>
        <p><strong>Durée</strong> : #{circuit.durée}</p>
        <p><strong>Participant</strong> : Illimitée personnes max</p>
        <p><strong>Motos recommandées</strong> : #{circuit.moto}</p>
        <p><strong>Difficulté</strong> : #{circuit.difficulté}</p>
        <p><strong>Tarifs</strong> : à partir de #{circuit.tarifs} €</p>
        """
      end
      |> Enum.join("") # Concatène toutes les chaînes en une seule
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
                  <li><button phx-click="show_card" phx-value-card={circuit.id} style="font-size:15px;height:3rem;border: 1px solid #e5e5e5;"><h6><strong><%= circuit.nom %></strong></h6></button></li>
                <%= end %>
              </ul>
            </nav>
          </div>
        </div>
      </div>
      <%= render_card(assigns) %>

      <!-- script js pour le carousel des images -->
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

  def render_card(%{selected_card: card} = assigns) do
    ~H"""
    <%= for c <- @circuit do %>
      <div class="container w-100">
        <div class="row">
            <h4 class="text-start"><%= c.nom %></h4>
          <div class="col-lg-4 col-md-12">
            <div class="container_image d-flex justify-content-end">
              <div class="carousel-inner">
                <div id="carousel-item-1" class="carousel-item active">
                  <img src={Routes.static_path(@socket, "/assets/images/section/" <> c.photo)} class="d-block w-100" alt="Image 1">
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
                    <li><button phx-click="change_content" phx-value-param={c.id}
                      style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-map"></i><br><strong>Destination</strong></button></li>
                    <li><button phx-click="change_liste" phx-value-param={c.id} style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-road"></i><br><strong>Itinéraire</strong></button></li>
                    <li><button phx-click="change_content" phx-value-param="parametre_personnalise_5" style="font-size:15px;height:5rem;width:9rem"><i class="fas fa-map-marker-alt"></i><br><strong>sites marquants</strong></button></li>
                    <li><button phx-click="change_content" phx-value-param="parametre_personnalise_2" style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-question"></i><br><strong>Questions</strong></button></li>
                    <li><button phx-click="change_content" phx-value-param="parametre_personnalise_3" style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-comment"></i><br><strong>Avis</strong></button></li>
                  </ul>
              </nav>
            </div>
            <div class="row mr-4" style="margin-top:5%" phx-show={@show_card_second}>
              <p>
              <blockquote>
                <i class='fa fa-quote-left fa-xs text-secondary'></i>
                  <%= c.remarque %>
                <i class='fa fa-quote-right fa-xs text-secondary'></i>
              </blockquote>
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
    <%= end %>
    """
  end


end
