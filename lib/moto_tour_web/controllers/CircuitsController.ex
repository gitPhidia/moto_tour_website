defmodule MotoTourWeb.CircuitsController do
  use MotoTourWeb, :controller
  alias MotoTourWeb.{Repo, Circuit}

  def liste(conn, _params) do
    # Récupérer tous les produits
    circuits = Repo.all(Circuit)

    # Passer les produits au template
    render(conn, "liste.html", circuits: circuits)
  end
  
end
