defmodule MotoTourWeb.MenuCardLive do
  use Phoenix.LiveView
  import Phoenix.HTML
  alias MotoTourWeb.Router.Helpers, as: Routes

   # Etat initial du LiveView
   def mount(_params, _session, socket) do
    {:ok, assign(socket, show_card: false, card_content: nil, show_second_card: false, second_card_content: nil)}
  end

  # Gérer le clic sur un menu (afficher la carte)
  def handle_event("toggle_card", %{"menu" => menu}, socket) do
    card_content = get_card_content(menu)
    {:noreply, assign(socket, show_card: true, card_content: raw(card_content), show_second_card: false, second_card_content: nil)}
  end

  # Gérer le clic sur un bouton de la carte (mettre à jour le contenu de la carte)
  def handle_event("change_content", %{"content" => content}, socket) do
    {:noreply, assign(socket, card_content: raw(content))}
  end

  # Gérer le clic sur le bouton 1 pour afficher une deuxième carte
  def handle_event("show_second_card", _params, socket) do
    second_card_content = "<p><u>Contenu de la deuxième carte</u></p><p>Cette carte apparaît après avoir cliqué sur le bouton 1.</p>"
    {:noreply, assign(socket, show_second_card: true, second_card_content: raw(second_card_content))}
  end

  # Fonction pour obtenir le contenu HTML en fonction du menu
  defp get_card_content("menu_1") do
    "<p><strong>Contenu dynamique du <em>Menu 1</em></strong></p>"
  end

  defp get_card_content("menu_2") do
    "<p><em>Contenu du <strong>Menu 2</strong></em></p>"
  end

  defp get_card_content("menu_3") do
    "<p><u>Contenu du <strong>Menu 3</strong></u></p>"
  end
end
