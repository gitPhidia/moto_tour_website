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

  def deshboard(conn, _params) do
    render(conn, "dashboard.html")
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

  def update(conn, %{"id" => id, "circuit" => circuit_params}) do
    circuit = Circuits.get_circuit!(id)

    # case Circuit.update_circuit(circuit, circuit_params) do
    case Circuit.changeset(circuit, circuit_params) |> Repo.update() do
      {:ok, circuit} ->
        conn
        |> put_flash(:info, "Circuit updated successfully.")
        |> redirect(to: Routes.circuits_path(conn, :edit, id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "editcircuit.html", circuit: circuit, changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    circuit = Circuits.get_circuit!(id)
    changeset = Circuits.change_circuit(circuit, %{})
    render(conn, "editcircuit.html", circuit: circuit, changeset: changeset)
  end

  def delete(conn, %{"id" => id}) do
    circuit = Circuits.get_circuit!(id)
    {:ok, _circuit} = Circuits.delete_circuit(circuit)

    conn
    |> put_flash(:info, "circuit deleted successfully.")
    |> redirect(to: Routes.circuits_path(conn, :index))
  end

  def archiver(conn, %{"id" => id}) do
    circuit = Circuits.get_circuit!(id)
    IO.inspect(circuit, label: "Changeset pour render")
    if circuit.archiver !== true do
      case Circuits.archivage(circuit.id) do
        {1, _} -> # {1, nil} est le format de retour de Repo.update_all
          conn
          |> put_flash(:info, "Circuit archivé avec succès.")
          |> redirect(to: Routes.page_path(conn, :bcircuit))

        {0, _} ->
          conn
          |> put_flash(:error, "Impossible d'archiver le circuit.")
          |> redirect(to: Routes.page_path(conn, :bcircuit))
      end
    else
      case Circuits.desarchivage(circuit.id) do
        {1, _} -> # {1, nil} est le format de retour de Repo.update_all
          conn
          |> put_flash(:info, "Circuit desarchivé avec succès.")
          |> redirect(to: Routes.page_path(conn, :bcircuit))

        {0, _} ->
          conn
          |> put_flash(:error, "Impossible de desarchiver le circuit.")
          |> redirect(to: Routes.page_path(conn, :bcircuit))
      end
    end
  end
end
