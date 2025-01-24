defmodule MotoTourWeb.BackLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    # Initialisation de la liste des champs
    {:ok, assign(socket, fields: [%{id: 1, value: ""}])}
  end

  def render(assigns) do
    ~L"""
    <div class="container">
      <h5>Le tarif comprend</h5>
      <%= for field <- @fields do %>
        <div class="form-group">
          <label for="field_<%= field.id %>">prestation <%= field.id %>:</label>
          <input type="text" id="field_<%= field.id %>" value="<%= field.value %>" class="form-control w-50" phx-change="update_field" phx-value-id="<%= field.id %>" />
        </div>
      <% end %>

      <button phx-click="add_field">Ajouter un champ</button>
    </div>
    """
  end

  def handle_event("add_field", _params, socket) do
    # Ajoute un champ de texte à la liste en incrémentant l'ID
    new_field = %{id: Enum.count(socket.assigns.fields) + 1, value: ""}
    {:noreply, update(socket, :fields, fn fields -> fields ++ [new_field] end)}
  end

  def handle_event("update_field", %{"id" => id, "value" => value}, socket) do
    # Met à jour la valeur du champ de texte correspondant à l'ID
    updated_fields = Enum.map(socket.assigns.fields, fn field ->
      if field.id == String.to_integer(id) do
        %{field | value: value}
      else
        field
      end
    end)
    {:noreply, assign(socket, :fields, updated_fields)}
  end
end
