defmodule MotoTourWeb.MenuCardLive do
  use Phoenix.LiveView
  import Phoenix.HTML
  alias MotoTourWeb.Router.Helpers, as: Routes

   # Etat initial du LiveView
   def mount(_params, _session, socket) do
    {:ok, assign(socket, show_card: false, card_content: nil, show_second_card: false, second_card_content: nil)}
  end

end
