defmodule MotoTourWeb.Card do
  use Phoenix.Component

  def card(assigns) do
  ~H"""
    <a href={@link}>
      <div class="card h-100 w-100" style="background-color: #F6F4F4;">
        <!-- Image Section -->
        <img src={ @image } class="card-img-top img-fluid" alt="Image des circuits">

        <!-- Orange Bar Section (Title) -->
        <div class="card-title-bar text-center py-1" style="color: #fff;">
          <h3 class="card-title m-0" style="font-size: 1.25rem;font-weight: normal; color: #333;"><%= render_slot(@nom_block) %></h3>
        </div>

        <!-- Card Body -->
        <div class="card-body text-left mt-0">
          <!-- Star Ranking Column -->
          <div class="col-lg-12 col-sm-6 d-flex justify-content-center" style="height:3rem">
            <.display_rating rate_count={@rate_count} max_rating_count={@max_rate_count}/>
          </div>
            <!-- Description Column -->
            <div class="col-lg-12 col-sm-6">
              <p class="card-text mb-0 d-flex justify-content-center text-center align-items-center" style="font-size: 0.9rem; line-height: 1.4;height: 4rem;">
                <%= render_slot(@description_block) %>
              </p>
            </div>

          <!-- Row pour le prix et le bouton Réserver -->
          <div class="row">
            <div class="col-lg-10 d-flex text-align-center align-items-center">
              <.display_price price={@price} />
            </div>
          </div>

        </div>
      </div>
    </a>
  """
end


  defp display_price(assigns)  do
    ~H"""
        <p class="card-price mb-0 test d-flex text-align-end align-items-end" style="font-size: 1.7rem; font-weight: bold;margin-left:40%;">
          <%= @price %>,00 €
        </p>
    """
  end

  defp display_rating(assigns) do
    ~H"""
      <div class="star-rating" style="font-size: 1.5rem; color: gold;">
        <!-- Calculer le nombre d'étoiles pleines à afficher (ne jamais dépasser max_rating_count) -->
        <%= for _ <- 1..min(@rate_count, @max_rating_count) do %>
          <img src="/assets/images/section/circuit_image/chilli-pepper-icon.svg" alt="Difficulté circuits" style="width: 24px; height: 30px;">
        <% end %>

        <!-- Affichage des étoiles vides pour compléter jusqu'à max_rating_count -->
        <!-- il faut s'assurer que rate_count ne depasse pas max_rate_count !-->
        <%= if(@rate_count < @max_rating_count) do %>
          <%= for _ <- (min(@rate_count, @max_rating_count) + 1)..@max_rating_count do %>
          <img src="/assets/images/section/circuit_image/chili-vegetable-icon.svg" alt="Difficulté circuits" style="width: 24px; height: 30px; opacity: 0.3;">
          <% end %>
        <% end %>
      </div>
    """
  end

end
