defmodule MotoTourWeb.BackLive do
  use Phoenix.LiveView
  alias MotoTourWeb.Router.Helpers, as: Routes
  alias MotoTour.Circuits
  alias MotoTour.Reservations
  import Phoenix.HTML

  @impl true
  def mount(_params, _session, socket) do
    # Initialisation d'une liste d'éléments
    socket = assign(socket, :items, ["Item 1", "Item 2", "Item 3", "Item 4"])
    {:ok, socket}
  end

  @impl true
  def handle_event("reorder", %{"from" => from_index, "to" => to_index}, socket) do
    items = socket.assigns.items
    from_index = String.to_integer(from_index)
    to_index = String.to_integer(to_index)

    # Réorganiser la liste
    updated_items =
      items
      |> List.delete_at(from_index)
      |> List.insert_at(to_index, Enum.at(items, from_index))

    {:noreply, assign(socket, :items, updated_items)}
  end

  def render(assigns) do
    ~H"""
    <div id="drag-drop-container" phx-hook="DragDrop">
      <%= for {item, index} <- Enum.with_index(@items) do %>
        <div
          class="draggable-item"
          draggable="true"
          data-index={index}>
          <%= item %>
        </div>
      <% end %>
    </div>
    """
  end

end
