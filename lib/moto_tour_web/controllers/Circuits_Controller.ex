defmodule MotoTourWeb.CircuitsController do
  use MotoTourWeb, :controller
  alias MotoTour.{Repo,Circuit}
  alias MotoTour.Circuits

  def liste(conn, _params) do
    # Récupérer tous les produits
    circuits = Repo.all(Circuit)

    # Passer les produits au template
    render(conn, "liste.html", circuits: circuits)
  end

  def bcircuit(conn, _params) do
    cir = Circuits.list_circuits()
    render(conn, "backcircuit.html", circuit: cir)
  end

  def ajoutc(conn, _params) do
    changeset = Circuits.change_circuit(%Circuit{})
    render(conn, "ajoutcircuit.html", changeset: changeset)
  end

  def create(conn, %{"circuit" => circuit_params}) do
    case Circuits.create_circuit(circuit_params) do
      {:ok, circuit} ->
        conn
        |> put_flash(:info, "circuit created successfully.")
        |> redirect(to: Routes.circuits_path(conn, :ajoutc, circuit_params))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "ajoutcircuit.html", changeset: changeset)
    end
  end
end
