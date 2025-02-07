defmodule MotoTourWeb.TarifLive do
  use Phoenix.LiveView
  alias MotoTour.Repo
  alias MotoTour.Tarif
  alias MotoTour.Tarifs
  alias MotoTour.Nontarif
  alias MotoTour.Nontarifs
  alias MotoTour.Circuits

  def mount(%{"id" => id}, _session, socket) do
    # Initialisation de la liste des champs
    circuit = Circuits.get_circuit!(id)
    tarif = Tarifs.list_tarifs(id)
    ntarif = Nontarifs.list_nontarifs(id)
    {:ok, assign(socket, tarif: tarif, nontarif: ntarif, circuit: circuit, idcircuit: id, fields: [%{id: 1, value: ""}], nfields: [%{id: 1, value: ""}])}
  end

  def render(assigns) do
    ~L"""
      <div class="row">

      <!-- prestation comprise -->
        <div class="col-md-6">
        <h5>Les préstations comprisent pour <%= @circuit.nom %> </h5>
          <form id="tarif-form" phx-submit="submit_tarifs" phx-change="update_fields">
            <!-- Champ caché pour l'ID du circuit -->
            <input type="hidden" name="idcircuit" value="<%= @idcircuit %>" />

            <%= for field <- @fields do %>
              <div class="form-group d-flex align-items-center">
                <label for="field_<%= field.id %>">Prestation <%= field.id %> : </label>
                <input type="text"
                      name="fields[<%= field.id %>]"
                      value="<%= field.value %>"
                      class="form-control w-75"
                      phx-debounce="500" />
                      <button type="button" class="rounded" phx-click="remove_field" phx-value-id="<%= field.id %>" style="padding: 5px 10px; background-color: grey; color: white; border: none; border-radius: 5px;"><i class="fa fa-minus"></i>
                      </button>
              </div>
            <% end %>

            <div class="form-group">
              <button type="button" phx-click="add_field" style="padding: 5px 10px; background-color: #0d6efd; color: white; border: none; border-radius: 5px;"><i class="fa fa-plus"></i> Ajouter un champ</button>
              <button type="submit" style="padding: 5px 10px; background-color: green; color: white; border: none; border-radius: 5px;">Enregistrer</button>
            </div>
          </form>

          <table class="table">
            <thead>
                <tr>
                  <th style="text-align: center;">Numéro</th>
                  <th style="text-align: center;">Préstation</th>
                  <th style="text-align: center;">Action</th>
                </tr>
            </thead>
            <tbody>
              <%= for {t, index} <- Enum.with_index(@tarif, 1) do %>
                <tr>
                  <td style="text-align: center;"><%= index %></td>
                  <td style="text-align: center;"><%= t.prestation %></td>
                  <td style="text-align: center;">
                  <a data-bs-toggle="tooltip" data-bs-placement="top" title="Modifier la préstation" href="/admin/prestation/<%= t.id %>"><i class="fa fa-pencil"></i></a>
                  <span>
                    <button type="button" phx-click="delete_tarif" phx-value-id="<%= t.id %>" style="padding: 5px 10px; background-color: grey; color: white; border: none; border-radius: 5px;">
                      Supprimer
                    </button>
                  </span>
                  </td>
                </tr>

              <%= end %>
          </table>
        </div>

        <!-- prestation non comprise -->
        <div class="col-md-6">
        <h5>Les préstations non comprisent pour <%= @circuit.nom %> </h5>
          <form id="tarif-form" phx-submit="submit_ntarifs" phx-change="update_nfields">
            <!-- Champ caché pour l'ID du circuit -->
            <input type="hidden" name="idcircuit" value="<%= @idcircuit %>" />

            <%= for field <- @nfields do %>
              <div class="form-group d-flex align-items-center">
                <label for="field_<%= field.id %>">Prestation <%= field.id %> : </label>
                <input type="text"
                  name="nfields[<%= field.id %>]"
                  value="<%= field.value %>"
                  class="form-control w-75"
                  phx-debounce="500" />
                  <button type="button" class="rounded" phx-click="remove_nfield" phx-value-id="<%= field.id %>" style="padding: 5px 10px; background-color: grey; color: white; border: none; border-radius: 5px;"><i class="fa fa-minus"></i></button>
              </div>
            <% end %>

            <div class="form-group">
              <button type="button" phx-click="add_nfield" style="padding: 5px 10px; background-color: #0d6efd; color: white; border: none; border-radius: 5px;"><i class="fa fa-plus"></i> Ajouter un champ</button>
              <button type="submit" style="padding: 5px 10px; background-color: green; color: white; border: none; border-radius: 5px;">Enregistrer</button>
            </div>
          </form>

          <table class="table">
            <thead>
                <tr>
                  <th style="text-align: center;">Numéro</th>
                  <th style="text-align: center;">Préstation non comprise</th>
                  <th style="text-align: center;">Action</th>
                </tr>
            </thead>
            <tbody>
              <%= for {t, index} <- Enum.with_index(@nontarif, 1) do %>
                <tr>
                  <td style="text-align: center;"><%= index %></td>
                  <td style="text-align: center;"><%= t.prestation %></td>
                  <td style="text-align: center;">
                  <a data-bs-toggle="tooltip" data-bs-placement="top" title="Modifier la préstation" href="/admin/nonprestation/<%= t.id %>"><i class="fa fa-pencil"></i></a>
                  <span>
                    <button type="button" phx-click="delete_ntarif" phx-value-id="<%= t.id %>" style="padding: 5px 10px; background-color: grey; color: white; border: none; border-radius: 5px;">
                      Supprimer
                    </button>
                  </span>
                  </td>
                </tr>

              <%= end %>
          </table>
        </div>
      </div>
    """
  end

  # Événement pour supprimer un champ spécifique
  def handle_event("remove_field", %{"id" => id}, socket) do
    id = String.to_integer(id)

    # Filtre la liste des champs pour exclure celui qui a l'ID donné
    updated_fields = Enum.reject(socket.assigns.fields, fn field -> field.id == id end)

    # Réassigner la liste mise à jour des champs
    {:noreply, assign(socket, :fields, updated_fields)}
  end

  def handle_event("add_field", _params, socket) do
    # Ajoute un champ de texte à la liste en incrémentant l'ID
    new_field = %{id: Enum.count(socket.assigns.fields) + 1, value: ""}
    {:noreply, update(socket, :fields, fn fields -> fields ++ [new_field] end)}
  end

  def handle_event("update_fields", %{"fields" => fields_params}, socket) do
    # Met à jour les valeurs des champs dans assigns
    updated_fields = Enum.map(socket.assigns.fields, fn field ->
      case Map.get(fields_params, Integer.to_string(field.id)) do
        nil -> field
        value -> %{field | value: value}
      end
    end)

    {:noreply, assign(socket, :fields, updated_fields)}
  end

  def handle_event("submit_tarifs", %{"idcircuit" => idcircuit, "fields" => fields_params}, socket) do
    Enum.each(fields_params, fn {_, prestation_value} ->
      %MotoTour.Tarif{}
      |> MotoTour.Tarif.changeset(%{prestation: prestation_value, idcircuit: String.to_integer(idcircuit)})
      |> Repo.insert()
    end)
    # Récupérer les tarifs mis à jour
    tarif = Tarifs.list_tarifs(idcircuit)

    {:noreply, assign(socket, :tarif, tarif)}
  end

  def handle_event("delete_tarif", %{"id" => id}, socket) do
    id = String.to_integer(id)

    case Repo.get(Tarif, id) do
      nil -> {:noreply, socket} # Pas de tarif trouvé, rien à faire
      tarif ->
        idcircuit = tarif.idcircuit
        Repo.delete!(tarif)

        # Recharger les tarifs après suppression
        tarifs = Tarifs.list_tarifs(socket.assigns.idcircuit)
        {:noreply, assign(socket, :tarif, tarifs)}
    end
  end


  # Événement pour supprimer un champ spécifique
  def handle_event("remove_nfield", %{"id" => id}, socket) do
    id = String.to_integer(id)

    # Filtre la liste des champs pour exclure celui qui a l'ID donné
    updated_fields = Enum.reject(socket.assigns.nfields, fn nfield -> nfield.id == id end)

    # Réassigner la liste mise à jour des champs
    {:noreply, assign(socket, :nfields, updated_fields)}
  end

  def handle_event("add_nfield", _params, socket) do
    # Ajoute un champ de texte à la liste en incrémentant l'ID
    new_field = %{id: Enum.count(socket.assigns.nfields) + 1, value: ""}
    {:noreply, update(socket, :nfields, fn nfields -> nfields ++ [new_field] end)}
  end

  def handle_event("update_nfields", %{"nfields" => fields_params}, socket) do
    # Met à jour les valeurs des champs dans assigns
    updated_fields = Enum.map(socket.assigns.nfields, fn nfield ->
      case Map.get(fields_params, Integer.to_string(nfield.id)) do
        nil -> nfield
        value -> %{nfield | value: value}
      end
    end)

    {:noreply, assign(socket, :nfields, updated_fields)}
  end

  def handle_event("submit_ntarifs", %{"idcircuit" => idcircuit, "nfields" => fields_params}, socket) do
    Enum.each(fields_params, fn {_, prestation_value} ->
      %MotoTour.Nontarif{}
      |> MotoTour.Nontarif.changeset(%{prestation: prestation_value, idcircuit: String.to_integer(idcircuit)})
      |> Repo.insert()
    end)
    # Récupérer les tarifs mis à jour
    nontarif = Nontarifs.list_nontarifs(idcircuit)

    {:noreply, assign(socket, :nontarif, nontarif)}
  end

  def handle_event("delete_ntarif", %{"id" => id}, socket) do
    id = String.to_integer(id)

    case Repo.get(Nontarif, id) do
      nil -> {:noreply, socket} # Pas de tarif trouvé, rien à faire
      nontarif ->
        idcircuit = nontarif.idcircuit
        Repo.delete!(nontarif)

        # Recharger les tarifs après suppression
        nontarifs = Nontarifs.list_nontarifs(socket.assigns.idcircuit)
        {:noreply, assign(socket, :nontarif, nontarifs)}
    end
  end

end
