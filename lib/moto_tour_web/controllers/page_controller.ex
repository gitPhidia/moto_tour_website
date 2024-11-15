defmodule MotoTourWeb.PageController do
  use MotoTourWeb, :controller
  alias MotoTour.Circuits

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def liste(conn, _params) do
    circuits = Circuits.list_circuits()
    # Passer les produits au template
    render(conn, "liste.html", circuits: circuits)
  end
end
