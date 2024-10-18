defmodule MotoTourWeb.HomeLive do
  use Phoenix.LiveView
  alias MotoTourWeb.Router.Helpers, as: Routes
  import MotoTourWeb.Card

  @impl true
  def mount(_params, _session, socket) do
    layout = {MotoTourWeb.LayoutView , "main_layout.html"}
    {:ok,
      socket
          |>assign(
            message: "hello world !",
            count: 3 ,
            max_rate_count_for_card: 5
            )
          #layout: layout
    }
  end

  @impl true
  def render(assigns) do
    ~H"""





    <div class="container-fluid mt-5">
    <p>haha</p>
      <div class="row">

          <.card
            image={Routes.static_path(@socket, "/assets/images/section/motorcycle-rider-offroad-gravel-track.jpg")}
            rate_count={@count}
            max_rate_count={@max_rate_count_for_card}
           >
            <:description_block>
               Description rapide du produit 1. Cette description peut être plus longue et s'adaptera sans perturber l'alignement.
            </:description_block>
         </.card>
      </div>

    </div>
    """
  end
end
