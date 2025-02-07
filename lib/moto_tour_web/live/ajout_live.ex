defmodule MotoTourWeb.AjoutLive do
  use Phoenix.LiveView
  alias MotoTour.Circuits
  alias MotoTour.Itineraires
  alias MotoTour.Itineraire
  import Phoenix.HTML.Form
  alias MotoTourWeb.Router.Helpers, as: Routes

  def mount(%{"id" => id}, _session, socket) do
    # Initialisation de la liste des champs
    circuit = Circuits.get_circuit!(id)
    itineraire = %MotoTour.Itineraire{}
    changeset = Itineraire.changeset(itineraire, %{})
    {:ok, assign(socket,circuits: circuit, changeset: changeset, id: id, show_popup: false)}
  end

  def render(assigns) do
    ~H"""
    <div class="container w-75">
    <h5>Ajouter un itinéraire <%= @circuits.nom %></h5>
    <a href={Routes.itineraire_path(@socket, :liste, @id)}>Retour</a>

      <form id="itineraire-form" phx-submit="submit_itineraire">
        <div class="form-group d-flex align-items-center">
          <label style="width: 130px;">Numéro d’étape</label>
          <input type="number" name="numero" class="form-control"/>
        </div>

        <div class="form-group d-flex align-items-center">
          <label style="width: 130px;">Jour</label>
          <input type="number" name="jour" class="form-control" />
        </div>

        <div class="form-group d-flex align-items-center">
          <label style="width: 130px;">Lieu de depart</label>
          <input type="text" name="depart" class="form-control" />
        </div>

        <div class="form-group d-flex align-items-center">
          <label style="width: 130px;">Lieu d'arriver</label>
          <input type="text" name="arriver" class="form-control" />
        </div>

        <div class="form-group d-flex align-items-center">
          <label style="width: 130px;">Distance</label>
          <input type="text" name="distance" class="form-control" />
        </div>

        <div class="form-group" style="display: flex; align-items: center;">
          <label style="width: 130px;">Description</label>
          <textarea name="remarque" style="height: 200px;" />
        </div>

        <input type="hidden" name="idcircuit" value={@id} class="form-control" />

        <div class="form-group d-flex align-items-end justify-content-end">
          <button style="margin-top: 10px; padding: 5px 10px; background-color: blue; color: white; border: none; border-radius: 5px;" type="submit">Enregistrer</button>
        </div>
      </form>
    </div>

    <%= if @show_popup do %>
      <div id="popup" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); display: flex; justify-content: center; align-items: center; z-index: 1000;">
        <div style="background: white; padding: 20px; border-radius: 10px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.5); width: 300px; text-align: center;">
          <h4>Attention</h4>
          <p>Le numero d'étape existe déja, voulez vous remplacer l'étape existant?</p>
          <button phx-click="remplacer" style="margin-top: 10px; padding: 5px 10px; background-color: red; color: white; border: none; border-radius: 5px;">
            remplacer
          </button>
          <button phx-click="close_popup" style="margin-top: 10px; padding: 5px 10px; background-color: grey; color: white; border: none; border-radius: 5px;">
            annuler
          </button>
        </div>
      </div>
    <% end %>
    """
  end

  def handle_event("close_popup", _params, socket) do
    {:noreply, assign(socket, show_popup: false)}
  end

  def handle_event("remplacer", _params, socket) do
    # Récupération des paramètres nécessaires
    numero = socket.assigns.numero
    idcircuit = socket.assigns.id
    jour = socket.assigns.jour
    depart = socket.assigns.depart
    arriver = socket.assigns.arriver
    distance = socket.assigns.distance
    remarque = socket.assigns.remarque
    itineraire_params = %{numero: numero, idcircuit: idcircuit, jour: jour,
    depart: depart, arriver: arriver, distance: distance, remarque: remarque}

    # Suppression des itinéraires existants avec ce numéro
    Itineraires.supprimer_par_numero(numero, idcircuit)

    # Création du nouvel itinéraire
    case Itineraires.create_itineraire(itineraire_params) do
      {:ok, itineraire} ->
        {:noreply,
         socket
         |> put_flash(:info, "Itinéraire remplacé avec succès!")
         |> push_redirect(to: "/admin/newitineraire/#{itineraire.idcircuit}")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset, show_popup: false)}
    end
  end

  def handle_event("submit_itineraire",%{"numero" => numero, "jour" => jour, "depart" => depart,
  "arriver" => arriver, "distance" => distance,
  "remarque" => remarque, "idcircuit" => idcircuit}, socket) do

    circuit = Circuits.get_circuit!(idcircuit)
    itineraire_params = %{
      numero: parse_integer(numero),
      jour: parse_integer(jour),
      depart: depart,
      arriver: arriver,
      distance: distance,
      remarque: remarque,
      idcircuit: parse_integer(idcircuit)
    }
    changeset = Itineraires.change_itineraire(%Itineraire{}, itineraire_params)
    if changeset.valid? do
      if not is_nil(numero) and numero != "" do
        cond do
          Itineraires.verification(parse_integer(numero), idcircuit) != [] ->
            # Affiche un pop-up en assignant une variable dans le socket
            {:noreply, assign(socket, show_popup: true, changeset: changeset, id: idcircuit, numero: parse_integer(numero),jour: parse_integer(jour),depart: depart,arriver: arriver,distance: distance,remarque: remarque)}

          Itineraires.verification(parse_integer(numero), idcircuit) == [] ->
            case Itineraires.create_itineraire(itineraire_params) do
              {:ok, itineraire} ->
                {:noreply,
                socket
                |> put_flash(:info, "Itinéraire enregistré avec succès!")
                |> push_redirect(to: "/admin/newitineraire/#{itineraire.idcircuit}")}

              {:error, %Ecto.Changeset{} = changeset} ->
                {:noreply, assign(socket, changeset: changeset, id: idcircuit,circuits: circuit, show_popup: false)}
            end
        end
      else
        case Itineraires.create_itineraire(itineraire_params) do
          {:ok, itineraire} ->
            {:noreply,
            socket
            |> put_flash(:info, "Itinéraire enregistré avec succès!")
            |> push_redirect(to: "/admin/newitineraire/#{itineraire.idcircuit}")}

          {:error, %Ecto.Changeset{} = changeset} ->
            {:noreply, assign(socket, changeset: changeset, id: idcircuit,circuits: circuit, show_popup: false)}
        end
      end
    else
      {:noreply, assign(socket, changeset: changeset, id: idcircuit, circuits: circuit, show_popup: false)}
    end
  end

  defp parse_integer(""), do: nil
  defp parse_integer(value), do: String.to_integer(value)

end
