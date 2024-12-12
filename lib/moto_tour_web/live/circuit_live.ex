defmodule MotoTourWeb.CircuitLive do
  use Phoenix.LiveView
  import Phoenix.HTML
  alias MotoTourWeb.Router.Helpers, as: Routes
  alias MotoTour.Circuits
  alias MotoTour.Itineraires
  alias MotoTour.Image

  def mount(_params, _session, socket) do
    # Assignez le chemin de l'image dans l'état du socket
    circuits = Circuits.list_circuits()
    # prend la premiere enregistrement dans la map de circuits
    first_circuit = List.first(circuits)
    # transorme les resultat en html,voir la foncrion function
    second_card_content_html = function_destination(first_circuit.id)
    # prend les photos de chaque circuit
    photo = Image.get_photo_circuit(first_circuit.id)
    {:ok, assign(socket, selected_card: [first_circuit.id], circuit: [first_circuit], photo: photo, circuits: circuits, show_card_second: true, card_content: raw(second_card_content_html)) }
  end

  def handle_param(%{"id" => id}, socket) do
    circuits = Circuits.list_circuits()
    circuit = Circuits.get_circuit!(id)

    # Appelle la fonction pour générer le contenu HTML
    second_card_content_html = function_destination(id)

    # Assigne les données au socket
    {:noreply,
     assign(socket,
       selected_card: [circuit.id],
       circuit: [circuit],
       circuits: circuits,
       show_card_second: true,
       card_content: raw(second_card_content_html)
     )}
  end

  def handle_event("change_photo",  %{"param" => param}, socket) do
    socket = reset_content(socket)
    photo = Image.get_photo_circuit(param)
    second_card_html =
      """
        <h3 class="fw-bold" style="color: #333; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1); font-size: 2em;">
          Photos
        </h3>
        #{Enum.map(photo, fn p ->
        """
          <div class="col-lg-3 col-md-5 mt-2 col-xs-6 thumb">
            <a class="thumbnail" href="#" data-image-id="" data-toggle="modal" data-title=""
              data-image="/assets/images/section/circuit_image/#{p.photo}"
              data-target="#image-gallery#{p.id}">
              <img src="/assets/images/section/circuit_image/#{p.photo}" class="img-fluid rounded w-100" alt="Image 1">
            </a>
          </div>

          <div class="modal fade" id="image-gallery#{p.id}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content align-items-end">
                  <h4 class="modal-title" id="image-gallery-title"></h4>
                  <button type="button" class="btn-close close" data-dismiss="modal"><span aria-hidden="true">X</span><span class="sr-only">Close</span>
                  </button>
                  <div class="modal-body">
                    <img id="image-gallery-image" class="img-responsive col-md-12" src="/assets/images/section/circuit_image/#{p.photo}">
                  </div>
                </div>
            </div>
          </div>
        """
        end)
        |> Enum.join("")}
      """
      # Retourner le tuple {:noreply, socket} avec l'assignement
      {:noreply, assign(socket, show_card_second: true, card_content: raw(second_card_html))}
  end

  # montre la card: l'image et le tab de destination
  def handle_event("show_card", %{"card" => card}, socket) do
    cards= Circuits.single_circuit(card)
    second_card_content_html = function_destination(card)
    socket = reset_content(socket)
    photo = Image.get_photo_circuit(card)
    {:noreply, assign(socket, selected_card: card, photo: photo, circuit: cards, card_content: raw(second_card_content_html))}
  end

  # montre les contenue du boutton destination
  def handle_event("change_content",  %{"param" => param}, socket) do
    second_card_content_html = function_destination(param)
    socket = reset_content(socket)
    {:noreply, assign(socket, show_card_second: true, card_content: raw(second_card_content_html))}
  end

  # montre la liste des itineraire
  def handle_event("change_liste",  %{"param" => param}, socket) do
    second_card_itineraire_html = function_itineraire(param)
    socket = reset_content(socket)
    {:noreply, assign(socket, show_card_second: true, card_content: raw(second_card_itineraire_html))}
  end

  # handle event pour le boutton question
  def handle_event("change_question",  %{"param" => param}, socket) do
    socket = reset_content(socket)
    second_card_html =
      """
        <h3 class="fw-bold" style="color: #333; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1); font-size: 2em;">
          Questions
        </h3>
        <p>nom</p>
        <input type='text'>
        <p>E-mail</p>
        <input type='email'>
        <p>Message</p>
        <input type='text'>
        <div class="text-center mt-3 position-relative d-flex justify-content-md-center">
          <a href="#" class="btn btn-responsive" style="background-color: orange; color: white;">envoyer un message</a>
        </div>
        """
    {:noreply, assign(socket, show_card_second: true, card_content: raw(second_card_html))}
  end

  # H E pour le boutton programme de voyage
  def handle_event("change_remarque",  %{"param" => param}, socket) do
    socket = reset_content(socket)
    second_card_content = Circuits.single_circuit(param)
    second_card_content_html =
      for circuit <- second_card_content do
        """
        <p>#{circuit.details}</p>
        """
      end
    |> Enum.join("") # Concatène toutes les chaînes en une seule
    {:noreply, assign(socket, show_card_second: true, card_content: raw(second_card_content_html))}
  end

  defp reset_content(socket) do
    assign(socket, card_content: %{}, show_card_second: false)
  end

  # concatène les resultats en html
  defp function_itineraire(param) do
    second_card_content = Itineraires.list_itineraire()
    filtered_content = Enum.filter(second_card_content, fn c -> c.idcircuit == String.to_integer(param) end)
    second_card_itineraire_html =
    """
      <div id='accordion'>
        #{Enum.map(filtered_content, fn c ->
        """
        <div class='card'>
          <div class='card-header' id='headingOne'>
              <div class='row'>
                <div class='col-md-11'>
                  <a data-toggle='collapse' data-target='#collapse#{c.id}' aria-expanded='true' aria-controls='collapse#{c.id}'>
                    <h6 class='mb-0'>
                      #{c.itineraire}
                    </h6>
                  </a>
                </div>
                <div class='col-md-1 mt-1'>
                  <a data-toggle='collapse' data-target='#collapse#{c.id}' aria-expanded='true' aria-controls='collapse#{c.id}'>
                    <i class='fa fa-angle-down' aria-hidden='true'></i>
                  </a>
                </div>
              </div>

            <div id='collapse#{c.id}' class='collapse' aria-labelledby='heading#{c.id}' data-parent='#accordion'>
              <div class='card-body'>
                #{c.remarque}
              </div>
            </div>
          </div>
        </div>
        """
        end)
        |> Enum.join("")}
      </div>
    """
  end

  # concatène les resultats en html
  defp function_destination(param) do
    second_card_content = Circuits.single_circuit(param)
    second_card_content_html =
      for circuit <- second_card_content do
        """
        <p><strong>Destination</strong> : #{circuit.desc_card}</p>
        <p><strong>Durée</strong> : #{circuit.durée}</p>
        <p><strong>Participant</strong> : #{circuit.participant}</p>
        <p><strong>Motos disponnible</strong> : #{circuit.moto}</p>
        """
      end
    |> Enum.join("") # Concatène toutes les chaînes en une seule
  end

  def render(assigns) do
    ~H"""
     <section class="transition-section py-5" style="height:130px;">
        <div class="container" style="margin-top:20px;">
          <div class="row text-white">
            <!--Première colonne : Image -->
            <div class="col-md-2 d-flex justify-content-center align-items-center">
              <img src={ Routes.static_path(@socket, "/assets/images/section/logo.png") } alt="Image de transition" class="img-fluid" style="max-width: 100%; height: auto;">
            </div>

            <!--Deuxième colonne : Texte -->
            <div class="col-md-10 d-flex justify-content-center align-items-center">
              <p class="text-center lead"><h5>"Vivez une nouvelle expérience avec nos parcours inoubliables."</h5></p>
            </div>

          </div>
        </div>
      </section>

      <!-- liste des crircuits -->
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
      <!-- fin -->

      <%= render_card(assigns) %>

    """
  end

  # rendue de chaque cricuit par rapport a la base de donnée
  def render_card(%{selected_card: card} = assigns) do
    ~H"""
    <%= for c <- @circuit do %>
      <div class="container w-100">
        <div class="row">

          <!-- titre & prix -->
          <div class="col-md-5">
            <h4 class="fw-bold"  style="color: #333; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1); font-size: 2em;"><%= c.nom %></h4>
          </div>
          <div class="col-md-4">
            <h4 class="fw-bold"  style="color: #333; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1); font-size: 2em;">
            <%= for i <- 1..5 do %>
              <%= if i <= c.difficulté do %>
                🌶️
              <% else %>
                <img src="/assets/images/section/circuit_image/hot-pepper.svg" alt="Hot Pepper" style="width: 32px; height: 32px; opacity: 0.3;">
              <% end %>
            <% end %>
            </h4>
          </div>
          <div class="col-md-3">
            <h4 class="fw-bold text-success" style="color: #333; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1); font-size: 2em;">à partir de <%= c.tarifs %>€</h4>
          </div>
          <!-- titre -->

          <!-- html image carousel -->
          <div class="col-lg-4 col-md-12">
            <div class="container_image d-flex justify-content-end">
              <div class="carousel-inner">
                <%= for {p, index} <- Enum.with_index(@photo, 1) do %>
                  <div id={"carousel-item-#{index}"} class={"carousel-item #{if index == 1, do: "active", else: ""}"}>
                    <img src={Routes.static_path(@socket, "/assets/images/section/circuit_image/" <> p.photo)} class="img-fluid rounded w-100" alt="Image 1">
                  </div>
                <%= end %>
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
            <!-- empty space -->
            <div class="vc_empty_space" style="height: 30px">
              <span class="vc_empty_space_inner"></span>
            </div>
            <!-- fin -->
          </div>
          <!-- fin du carousel -->

          <!-- deuxieme partie du card -->
          <div class="col-lg-8 col-md-12 mb-4">

            <!-- liste des boutton pour chaque card -->
            <div class="product-menu text-center">
              <nav>
                <ul class="circuitpage">
                  <li><button phx-click="change_content" phx-value-param={c.id}
                    style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-map"></i><br><strong>Destination</strong></button></li>
                  <li><button phx-click="change_liste" phx-value-param={c.id} style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-road"></i><br><strong>Itinéraire</strong></button></li>
                  <li><button phx-click="change_remarque" phx-value-param={c.id} style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-calendar"></i><br><strong>Préstations et sites marquant</strong></button></li>
                  <li><button phx-click="change_question" phx-value-param={c.id} style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-question"></i><br><strong>Questions</strong></button></li>
                  <li><button phx-click="change_photo" phx-value-param={c.id} style="font-size:15px;height:5rem;width:9rem"><i class="fa fa-picture-o"></i><br><strong>Photos</strong></button></li>
                </ul>
              </nav>
            </div>
            <!-- fin du liste -->

            <div class="row mr-4" style="margin-top:5%" phx-show={@show_card_second}>
              <p>
              <!-- affichage du quote pour chaque circuit -->
              <blockquote>
                <i class='fa fa-quote-left fa-xs text-secondary'></i>
                  <%= c.remarque %>
                <i class='fa fa-quote-right fa-xs text-secondary'></i>
              </blockquote>
              <!-- fin du quote -->

              <!-- affichage des élements selectionné dans la liste de boutton -->
                <%= @card_content %>
              <!-- fin -->
              </p>
            </div>
          </div>
          <!-- fin de la deuxieme partie -->
        </div>
      </div>

      <script>
      function moveCarousel(direction) {
      // Récupère tous les éléments du carrousel
      const items = document.querySelectorAll('.carousel-item');

      // Trouve l'élément actif actuel
      const activeItem = document.querySelector('.carousel-item.active');

      // Trouve l'index de l'élément actif
      const activeIndex = Array.from(items).indexOf(activeItem);

      // Détermine le nouvel index
      let newIndex = activeIndex + direction;

      // Gestion des limites (boucle infinie)
      if (newIndex < 0) {
        newIndex = items.length - 1; // Aller au dernier élément
      } else if (newIndex >= items.length) {
        newIndex = 0; // Revenir au premier élément
      }

      // Change la classe active
      activeItem.classList.remove('active');
      items[newIndex].classList.add('active');
    }

    let carouselInterval; // Référence à l'intervalle

    function moveCarousel(direction) {
      const items = document.querySelectorAll('.carousel-item');
      const activeItem = document.querySelector('.carousel-item.active');
      const activeIndex = Array.from(items).indexOf(activeItem);
      let newIndex = activeIndex + direction;

      // Gestion des limites (boucle infinie)
      if (newIndex < 0) {
        newIndex = items.length - 1;
      } else if (newIndex >= items.length) {
        newIndex = 0;
      }

      activeItem.classList.remove('active');
      items[newIndex].classList.add('active');
    }

    function startCarousel(interval = 4000) {
      // Démarre un diaporama automatique toutes les `interval` millisecondes
      carouselInterval = setInterval(() => {
        moveCarousel(1); // Avance d'une image
      }, interval);
    }

    function stopCarousel() {
      // Arrête le diaporama automatique
      clearInterval(carouselInterval);
    }

    document.addEventListener('DOMContentLoaded', () => {
      startCarousel(); // Lance le diaporama au chargement de la page

      // Ajoute une pause au survol du carrousel
      const carousel = document.querySelector('.carousel');
      if (carousel) {
        carousel.addEventListener('mouseover', stopCarousel);
        carousel.addEventListener('mouseout', () => startCarousel());
      }
    });

    </script>

    <%= end %>
    """
  end

end
