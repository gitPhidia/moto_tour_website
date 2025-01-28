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

    json_ld = circuits |> Enum.map(&build_event_schema/1) |> Jason.encode!()
    {:ok, assign(socket, collapse_all: false, page_title: "Circuit & Location Moto à Madagascar",
    selected_card: [first_circuit.id], circuit: [first_circuit], photo: photo, circuits: circuits,
    show_card_second: true, card_content: raw(second_card_content_html),
    meta_description: "Madagascar est un pays montagneux mais aussi avec des parties désertiques, pour notre plus grand plaisir. Idéal au circuit enduro sport en moto",
    json_ld_schema: json_ld) }
  end

  def mount(%{}, _session, socket) do
    # Assignez le chemin de l'image dans l'état du socket
    circuits = Circuits.list_circuits()
    first_circuit = List.first(circuits)
    # transorme les resultat en html,voir la foncrion function
    second_card_content_html = function_destination(first_circuit.id)
    # prend les photos de chaque circuit
    photo = Image.get_photo_circuit(first_circuit.id)

    json_ld = circuits |> Enum.map(&build_event_schema/1) |> Jason.encode!()
    {:ok, assign(socket, collapse_all: false, page_title: "Circuit & Location Moto à Madagascar",
    selected_card: [first_circuit.id], circuit: [first_circuit], photo: photo, circuits: circuits,
    show_card_second: true, card_content: raw(second_card_content_html),
    meta_description: "Madagascar est un pays montagneux mais aussi avec des parties désertiques, pour notre plus grand plaisir. Idéal au circuit enduro sport en moto",
    json_ld_schema: json_ld) }
  end

  # Générer un balisage Schema.org pour un circuit donné
defp build_event_schema(circuit) do
  %{
    "@context" => "https://schema.org",
    "@type" => "Event",
    "name" => circuit.nom,
    "location" => %{
      "@type" => "Place",
      "name" => circuit.desc_card,
    },
    "description" => circuit.desc_card,
    "offers" => %{
      "@type" => "Offer",
      "url" => circuit.id,
      "price" => circuit.tarifs,
      "priceCurrency" => "EUR",
      "availability" => "https://schema.org/InStock"
    }
  }
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
    second_card_itineraire_html = function_itineraire(param, false)
    socket = reset_content(socket)
    {:noreply, assign(socket, show_card_second: true, card_content: raw(second_card_itineraire_html))}
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

  def handle_event("change_tarif",  %{"param" => param}, socket) do
    second_card_content_html = function_tarif(param)
    socket = reset_content(socket)
    {:noreply, assign(socket, show_card_second: true, card_content: raw(second_card_content_html))}
  end

  defp function_tarif(param) do
    second_card_content = Tarifs.list_tarifs(param)
    second_card_noncontent = Nontarifs.list_nontarifs(param)
    circuit = Circuits.get_circuit!(param)
    second_card_content_html =
      """
      <h5>TARIF & PRESTATIONS 2025 / à partir de #{circuit.tarifs} €</h5>
      <section class="lead-text" style="margin-top: -20px;">
        <h5 class="text-primary">Nos préstations comprennent</h5>
        <ul class="list-group">
         #{Enum.map(second_card_content, fn c ->
          """
            <li class="list-group-item">#{c.prestation}</li>
          """
        end)
          |> Enum.join("")}
        </ul>
      </section>

      <section class="lead-text" style="margin-top: -20px;">
        <h5 class="text-primary">Nos préstations ne comprennent pas</h5>
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
                      #{c.itineraire}
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
        <p><strong>Destination</strong> : #{circuit.desc_card}</p>
        <p><strong>Durée</strong> : #{circuit.durée}</p>
        <p><strong>Nombre de Participants</strong> : #{circuit.participant}</p>
        <p><strong>Moto disponibles</strong> : #{circuit.moto}</p>
        """
      end
    |> Enum.join("") # Concatène toutes les chaînes en une seule
  end

  def render(assigns) do
    ~H"""
     <section class="transition-section" style="height:50px;margin-top:30px;">
        <div class="container">
          <div class="row text-white">
            <div class="col-md-12 d-flex justify-content-center align-items-center">
              <p class="text-center lead"><h1 class="mt-3 fs-4 fs-md-3 fs-lg-2">"Vivez une nouvelle expérience avec nos parcours inoubliables."</h1></p>
            </div>
          </div>
        </div>
      </section>

      <!-- liste des crircuits -->
      <div class="row" style="height:40px;">
        <div class="col-md-12">
        <div class="product-menu text-center d-flex justify-content-center" style="border-bottom: 1px solid #e5e5e5;margin-top:-13px;">
            <nav>
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
  defp render_card(%{selected_card: card} = assigns) do
    ~H"""
    <%= for c <- @circuit do %>
      <div class="container w-100">
        <div class="row" style="margin-top: -20px;">

          <!-- titre & prix -->
          <div class="col-md-5">
            <h4 class="fw-bold"  style="color: #333; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1); font-size: 2em;"><%= c.nom %></h4>
          </div>
          <div class="col-md-4">
            <h4 class="fw-bold"  style="color: #333; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1); font-size: 2em;">
            <%= for i <- 1..5 do %>
              <%= if i <= c.difficulté do %>
              <img src="/assets/images/section/circuit_image/chilli-pepper-icon.svg" alt="Hot Pepper" style="width: 30px; height: 24px;">
              <% else %>
              <img src="/assets/images/section/circuit_image/chili-vegetable-icon.svg" alt="Hot Pepper" style="width: 30px; height: 24px; opacity: 0.3;">
              <% end %>
            <% end %>
            </h4>
          </div>
          <div class="col-md-3">
            <h4 class="fw-bold text-success" style="color: #333; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1); font-size: 2em;">à partir de <%= c.tarifs %>€</h4>
          </div>
          <!-- titre -->

          <!-- html image carousel -->
          <div class="col-lg-4 col-md-12" style="height: 41rem;">
            <div class="container_image d-flex justify-content-end">
              <div class="carousel-inner">
                <%= for {p, index} <- Enum.with_index(@photo, 1) do %>
                  <div id={"carousel-item-#{index}"} class={"carousel-item #{if index == 1, do: "active", else: ""}"}>
                    <img src={Routes.static_path(@socket, "/assets/images/section/circuit_image/" <> p.photo)} class="img-fluid rounded w-100" alt="Image 1" style="height: 100%;">
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
          </div>
          <!-- fin du carousel -->

          <!-- deuxieme partie du card -->
          <div class="col-lg-8 col-md-12">

            <!-- liste des boutton pour chaque card -->
            <div class="product-menu text-center">
              <nav>
                <ul class="circuitpage">
                  <li><button phx-click="change_content" phx-value-param={c.id} style="font-size:15px;height:4rem;width:7rem"><i class="fa fa-map"></i><br><strong>Destination</strong></button></li>
                  <li><button phx-click="change_liste" phx-value-param={c.id} style="font-size:15px;height:4rem;width:7rem"><i class="fa fa-road"></i><br><strong>Itinéraire</strong></button></li>
                  <li><button phx-click="change_remarque" phx-value-param={c.id} style="font-size:15px;height:4rem;width:10rem"><i class="fa fa-calendar"></i><br><strong>Sites marquants</strong></button></li>
                  <li><button phx-click="change_tarif" phx-value-param={c.id} style="font-size:15px;height:4rem;width:7rem"><i class="fa fa-euro-sign"></i><br><strong>Tarifs</strong></button></li>
                  <li><button phx-click="change_photo" phx-value-param={c.id} style="font-size:15px;height:4rem;width:7rem"><i class="fa fa-picture-o"></i><br><strong>Photos</strong></button></li>
                </ul>
              </nav>
            </div>
            <!-- fin du liste -->

            <div class="row mr-4" style="margin-top:1%" phx-show={@show_card_second}>
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

      <%= if @json_ld_schema do %>
        <script type="application/ld+json">
          <%= raw @json_ld_schema %>
        </script>
      <% end %>

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
