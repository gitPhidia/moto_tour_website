defmodule MotoTourWeb.CircuitLive do
  use Phoenix.LiveView
  import Phoenix.HTML
  alias MotoTourWeb.Router.Helpers, as: Routes
  alias MotoTour.{Repo,Circuit}
  alias MotoTour.Circuits
  alias MotoTour.Itineraires
  alias MotoTour.Image
  alias MotoTour.Tarif
  alias MotoTour.Tarifs
  alias MotoTour.Nontarif
  alias MotoTour.Nontarifs
  alias MotoTour.Nav

  def mount(%{"id" => id}, _session, socket) do

    # Assignez le chemin de l'image dans l'état du socket
    circuits = Circuits.list_circuits()
    first_circuit = Repo.get!(Circuit, id)
    # transorme les resultat en html,voir la foncrion function
    second_card_content_html = function_destination(first_circuit.id)
    # prend les photos de chaque circuit
    photo = Image.get_photo_circuit(first_circuit.id)

    # json_ld = circuits |> Enum.map(&build_event_schema/1) |> Jason.encode!()
    {:ok, assign(socket, collapse_all: false, page_title: "Circuit & Location Moto à Madagascar",
    selected_card: [first_circuit.id], circuit: [first_circuit], photo: photo, circuits: circuits,
    show_card_second: true, card_content: raw(second_card_content_html),
    meta_description: "Madagascar est un pays montagneux mais aussi avec des parties désertiques, pour notre plus grand plaisir. Idéal pour circuit enduro en moto",
    id: id, active_content: 1) }
  end

  def mount(%{}, _session, socket) do
    # Assignez le chemin de l'image dans l'état du socket
    circuits = Circuits.list_circuits()
    first_circuit = List.first(circuits)
    # transorme les resultat en html,voir la foncrion function
    second_card_content_html = function_destination(first_circuit.id)
    # prend les photos de chaque circuit+
    photo = Image.get_photo_circuit(first_circuit.id)

    # json_ld = circuits |> Enum.map(&build_event_schema/1) |> Jason.encode!()
    {:ok, assign(socket, collapse_all: false, page_title: "Circuit & Location Moto à Madagascar",
    selected_card: [first_circuit.id], circuit: [first_circuit], photo: photo, circuits: circuits,
    show_card_second: true, card_content: raw(second_card_content_html),
    meta_description: "Madagascar est un pays montagneux mais aussi avec des parties désertiques, pour notre plus grand plaisir. Idéal pour circuit enduro en moto",
    id: Integer.to_string(first_circuit.id), active_content: 1) }
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
          <div class="col-lg-3 col-md-4 col-sm-6 col-12 mt-2 thumb">
            <a class="thumbnail" href="#" data-image-id="" data-toggle="modal" data-title="" data-image="/assets/images/section/circuit_image/#{p.photo}" data-target="#image-gallery#{p.id}">
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
                    <img id="image-gallery-image" class="img-fluid col-md-12" src="/assets/images/section/circuit_image/#{p.photo}">
                  </div>
                </div>
            </div>
          </div>
        """
        end)
        |> Enum.join("")}
      """
    # Retourner le tuple {:noreply, socket} avec l'assignement
    {:noreply, assign(socket, show_card_second: true, card_content: raw(second_card_html), active_content: 5)}
  end

  # montre la card: l'image et le tab de destination
  def handle_event("show_card", %{"card" => card}, socket) do
    cards= Circuits.single_circuit(card)
    second_card_content_html = function_destination(card)
    socket = reset_content(socket)
    photo = Image.get_photo_circuit(card)
    {:noreply, assign(socket, id: card, selected_card: card, photo: photo, circuit: cards, card_content: raw(second_card_content_html), active_content: 1)}
  end

  # montre les contenue du boutton destination
  def handle_event("change_content",  %{"param" => param}, socket) do
    second_card_content_html = function_destination(param)
    socket = reset_content(socket)
    {:noreply, assign(socket, show_card_second: true, card_content: raw(second_card_content_html), active_content: 1)}
  end

  # montre la liste des itineraire
  def handle_event("change_liste",  %{"param" => param}, socket) do
    second_card_itineraire_html = function_itineraire(param, false)
    socket = reset_content(socket)
    {:noreply, assign(socket, show_card_second: true, card_content: raw(second_card_itineraire_html), active_content: 2)}
  end

  # H E pour le boutton programme de voyage
  def handle_event("change_remarque",  %{"param" => param}, socket) do
    socket = reset_content(socket)
    second_card_content = Circuits.single_circuit(param)
    second_card_content_html =
      for circuit <- second_card_content do
        """
        <div class="container_details">
          <section class="lead-text">
            #{circuit.details}
          </section>
        </div>
        """
      end
    |> Enum.join("") # Concatène toutes les chaînes en une seule
    {:noreply, assign(socket, show_card_second: true, card_content: raw(second_card_content_html), active_content: 3)}
  end

  def handle_event("change_tarif",  %{"param" => param}, socket) do
    second_card_content_html = function_tarif(param)
    socket = reset_content(socket)
    {:noreply, assign(socket, show_card_second: true, card_content: raw(second_card_content_html), active_content: 4)}
  end

  defp function_tarif(param) do
    second_card_content = Tarifs.list_tarifs(param)
    second_card_noncontent = Nontarifs.list_nontarifs(param)
    circuit = Circuits.get_circuit!(param)
    second_card_content_html =
      """
      <h5 class="lead">TARIF & PRESTATIONS 2025 / à partir de #{circuit.tarifs} €</h5>
      <section class="lead-text" style="margin-top: -20px;">
        <h5 class="text-primary">Nos prestations comprennent</h5>
        <ul class="list-group">
         #{Enum.map(second_card_content, fn c ->
          """
            <li class="list-group-item">#{c.prestation}</li>
          """
        end)
          |> Enum.join("")}
        </ul>
      </section>

      <section class="lead-text">
        <h5 class="text-primary">Nos prestations ne comprennent pas</h5>
        <ul class="list-group">
         #{Enum.map(second_card_noncontent, fn c ->
          """
            <li class="list-group-item">#{c.prestation}</li>
          """
        end)
          |> Enum.join("")}
        </ul>
      </section>
      """
  end

  defp reset_content(socket) do
    assign(socket, card_content: %{}, show_card_second: false)
  end

  def handle_event("toggle_all", _params, socket) do
    # Alterner la valeur de `collapse_all` entre true et false
    new_collapse_all = not socket.assigns.collapse_all
    # Recalculer le HTML avec la nouvelle valeur de `collapse_all`
    second_card_itineraire_html = function_itineraire(socket.assigns.selected_card, new_collapse_all)

    # Mettre à jour l'état dans le socket
    {:noreply, assign(socket, collapse_all: new_collapse_all, card_content: raw(second_card_itineraire_html))}
  end

  def switch(true), do: "checked"
  def switch(false), do: ""

  def collapse_class(true), do: "collapse show"
  def collapse_class(false), do: "collapse"

  # concatène les resultats en html
  defp function_itineraire(param, collapse_all) do
    # Vérifier si param est déjà un entier ou une chaîne
    param_value =
      case param do
        %{"param" => value} -> value  # Si param est une carte, extraire "param"
        [value] -> value              # Si param est une liste, prendre le premier élément
        _ -> param                    # Si param est déjà une chaîne ou un entier, le laisser tel quel
      end

    # Vérifier si param_value est une chaîne et essayer de le convertir en entier
    param_int =
      case param_value do
        value when is_binary(value) ->  # Si value est une chaîne, essayer de le convertir
          case Integer.parse(value) do
            {int, _} -> int
            :error -> 0  # Valeur par défaut si la conversion échoue
          end
        _ -> param_value  # Si value est déjà un entier, on le garde tel quel
      end

    second_card_content = Itineraires.list_itineraire()
    filtered_content = Enum.filter(second_card_content, fn c -> c.idcircuit == param_int end)

    second_card_itineraire_html =
    """
    <div class="form-check form-switch d-flex justify-content-end">
      <input phx-click="toggle_all" class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault" #{switch(collapse_all)} style="height: 20px;width: 40px;">
      <label class="form-check-label" for="flexSwitchCheckDefault"> Masquer Tout / Afficher</label>
    </div>

      <div id='accordion'>
        #{Enum.map(filtered_content, fn c ->
        """
        <div class='card' id='heading#{c.id}'>
          <div class='card-header'>
              <div class='row'>
                <div class='col-md-11'>
                  <a data-toggle='collapse' data-target='#collapse#{c.id}' aria-expanded='true' aria-controls='collapse#{c.id}'>
                    <h6 class='mb-0'>
                      jour #{c.numero} : #{c.depart} - #{c.arriver} - #{c.distance}
                    </h6>
                  </a>
                </div>
                <div class='col-md-1'>
                  <a data-toggle='collapse' data-target='#collapse#{c.id}' aria-expanded='true' aria-controls='collapse#{c.id}'>
                    <i class='fa fa-angle-down' aria-hidden='true'></i>
                  </a>
                </div>
              </div>

            <div id='collapse#{c.id}' class='#{collapse_class(collapse_all)}' aria-labelledby='heading#{c.id}' data-parent='#accordion'>
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
          <!-- affichage du quote pour chaque circuit -->
          <blockquote>
            <i class='fa fa-quote-left fa-xs text-secondary'></i>
              #{circuit.remarque}
            <i class='fa fa-quote-right fa-xs text-secondary'></i>
          </blockquote>
          <!-- fin du quote -->
        <p><strong>Destination</strong> : #{circuit.desc_card}</p>
        <p><strong>Durée</strong> : #{circuit.durée}</p>
        <p><strong>Nombre de Participants</strong> : #{circuit.participant}</p>
        <p><strong>Moto disponibles</strong> : #{circuit.moto}</p>
        <p>#{circuit.details}</p>
        """
      end
    |> Enum.join("") # Concatène toutes les chaînes en une seule
  end

  def render(assigns) do
    ~H"""

      <!-- liste des crircuits -->
      <div class="row">
        <div class="col-md-12 mt-md-4 mt-5">
          <div class="product-menu text-center d-flex justify-content-center">
            <nav aria-label="navigation">
              <ul class="paginationlink d-flex flex-wrap justify-content-center">
                <%= for circuit <- @circuits do %>
                  <li class="page-item">
                    <a class={"page-lien d-flex align-items-center justify-content-center #{if circuit.id == String.to_integer(@id), do: "active", else: ""}"}
                      phx-click="show_card" phx-value-card={circuit.id} style="height: 40px;">
                      <h6 class="m-0"><strong><%= circuit.nom %></strong></h6>
                    </a>
                  </li>
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
  defp render_card(%{selected_card: card} = assigns) do
    ~H"""
    <%= for c <- @circuit do %>
      <div class="container">
        <div class="row">

        <div class="row align-items-center text-center text-md-start">

          <!-- Nom du circuit -->
          <div class="col-12 col-md-5 mb-md-0">
            <h4 class="fw-bold fs-5 fs-md-4" style="color: #333; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);">
              <%= c.nom %>
            </h4>
          </div>

          <!-- Difficulté du circuit -->
          <div class="col-12 col-md-4 d-flex justify-content-center justify-content-md-start mb-md-0">
            <%= for i <- 1..5 do %>
              <%= if i <= c.difficulté do %>
                <img src="/assets/images/section/circuit_image/chilli-pepper-icon.svg" alt="Difficulté des circuits" style="width: 28px; height: 22px;">
              <% else %>
                <img src="/assets/images/section/circuit_image/chili-vegetable-icon.svg" alt="Difficulté des circuits" style="width: 28px; height: 22px; opacity: 0.3;">
              <% end %>
            <% end %>
          </div>

          <!-- Tarif -->
          <div class="col-12 col-md-3">
            <h4 class="fw-bold text-success fs-5 fs-md-4" style="text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);">
              À partir de <%= c.tarifs %>€
            </h4>
          </div>

        </div>

          <!-- html image carousel -->
         <div class="col-lg-4 col-md-12 col-sm-12 col-12">
            <div class="container_image d-flex justify-content-center">
              <div class="carousel-inner" style="width: 100%; height: 300px;">
                <%= for {p, index} <- Enum.with_index(@photo, 1) do %>
                  <!-- <div id={"carousel-item-#{index}"} class={"carousel-item #{if index == 1, do: "active", else: ""}"}>
                    <img src={Routes.static_path(@socket, "/assets/images/section/circuit_image/" <> p.photo)} class="img-fluid rounded w-100 d-block" alt={"Image #{index}"} style="height: auto;max-height: 700px; object-fit: contain;">
                  </div> -->
                  <div id={"carousel-item-#{index}"} class={"carousel-item rounded #{if index == 1, do: "active", else: ""}"} style={"background-image: url(" <> Routes.static_path(@socket, "/assets/images/section/circuit_image/" <> p.photo) <> ");
                    background-size: contain;
                    background-position: center;
                    background-repeat: no-repeat;
                    width: 100%;
                    height: 300px;border-radius: 50%;"}></div>
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
          </div>
          <!-- fin du carousel -->

          <!-- deuxieme partie du card -->


          <!-- Deuxième partie du card -->
            <div class="col-lg-8 col-md-12" style="margin-top: -2%;">

              <!-- Liste des boutons pour chaque card -->
              <div class="product-menu">
                <nav>
                  <ul class="circuitpage d-flex justify-content-center list-unstyled">
                    <li>
                      <button class={"page-lien d-flex flex-column justify-content-center #{if @active_content == 1, do: "active", else: ""}"} style="font-size: 14px; height: 3.5rem; width: 7rem;"
                              phx-click="change_content" phx-value-param={c.id}>
                        <i class="fa fa-map"></i>
                        <strong>Destination</strong>
                      </button>
                    </li>
                    <li>
                      <button class={"page-lien d-flex flex-column justify-content-center #{if @active_content == 2, do: "active", else: ""}"} style="font-size: 14px; height: 3.5rem; width: 7rem;"
                              phx-click="change_liste" phx-value-param={c.id}>
                        <i class="fa fa-road"></i>
                        <strong>Itinéraire</strong>
                      </button>
                    </li>
                    <!-- <li>
                      <button class={"page-lien d-flex flex-column justify-content-center #{if @active_content == 3, do: "active", else: ""}"} style="font-size: 14px; height: 3.5rem; width: 7rem;"
                              phx-click="change_remarque" phx-value-param={c.id}>
                        <i class="fa fa-calendar"></i>
                        <strong>Sites marquants</strong>
                      </button>
                    </li> -->
                    <li>
                      <button class={"page-lien d-flex flex-column justify-content-center #{if @active_content == 4, do: "active", else: ""}"} style="font-size: 14px; height: 3.5rem; width: 7rem;"
                              phx-click="change_tarif" phx-value-param={c.id}>
                        <i class="fa fa-euro-sign"></i>
                        <strong>Tarifs</strong>
                      </button>
                    </li>
                    <li>
                      <button class={"page-lien d-flex flex-column justify-content-center #{if @active_content == 5, do: "active", else: ""}"} style="font-size: 14px; height: 3.5rem; width: 7rem;"
                              phx-click="change_photo" phx-value-param={c.id}>
                        <i class="fa fa-picture-o"></i>
                        <strong>Photos</strong>
                      </button>
                    </li>
                  </ul>
                </nav>
              </div>

              <!-- Fin de la liste des boutons -->

              <!-- Affichage du contenu sélectionné -->
              <div class="row mr-4 mt-4" phx-show={@show_card_second}>
                <p>
                <!-- affichage des élements selectionné dans la liste de boutton -->
                  <%= @card_content %>
                <!-- fin -->
                </p>
              </div>
              <!-- Fin de l'affichage du contenu -->
            </div>
            <!-- Fin de la deuxième partie -->

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

    function startCarousel(interval = 10000) {
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
