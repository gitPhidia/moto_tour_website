defmodule MotoTourWeb.ItineraireController do
  use MotoTourWeb, :controller
  alias MotoTour.{Repo,Circuit}
  alias MotoTour.Circuits
  alias MotoTour.Itineraires
  alias MotoTour.Itineraire

  def index(conn, _params) do
    circuits = Repo.all(Circuit)

    # Passer les produits au template
    render(conn, "index.html", circuits: circuits)
  end

  def liste(conn, %{"id" => id}) do
    # itineraire = Itineraires.itineraire_circuit(id)
    second_card_content = Itineraires.list_itineraire()
    filtered_content = Enum.filter(second_card_content, fn c -> c.idcircuit == String.to_integer(id) end)
    render(conn, "liste.html", itineraire: filtered_content)
  end

  def ajout(conn, _params) do
    changeset = Itineraires.change_itineraire(%Itineraire{})
    render(conn, "new.html", changeset: changeset)
  end
end
