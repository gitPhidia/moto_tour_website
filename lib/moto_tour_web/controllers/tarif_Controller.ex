defmodule MotoTourWeb.TarifController do
  use MotoTourWeb, :controller
  alias MotoTour.{Repo,Tarif}
  alias MotoTour.Tarifs

  def create(conn, %{"tarif" => tarif_params}) do
    for %{"prestation" => prestation_value} <- tarif_params do
      %Tarif{prestation: prestation_value}
      |> Tarif.changeset()
      |> Repo.insert()
    end

    conn
    |> put_flash(:info, "Prestations ajoutées avec succès")
    |> redirect(to: Routes.tarif_path(conn, :index))
  end

  def delete(conn, %{"id" => id}) do
    # Recherche et suppression du tarif
    case Repo.get(MotoTour.Tarif, id) do
      nil ->
        conn
        |> put_flash(:error, "Le tarif n'existe pas.")
        |> redirect(to: Routes.tarif_live_path(conn, :index)) # Redirige vers le LiveView principal en cas d'erreur

      tarif ->
        Repo.delete!(tarif)

        conn
        |> put_flash(:info, "Le tarif a été supprimé avec succès.")
        |> redirect(to: Routes.tarif_live_path(conn, :index)) # Redirige vers le LiveView après suppression
    end
  end

  def edit(conn, %{"id" => id}) do
    prestation = Repo.get!(Tarif, id)
    changeset = Tarifs.change_tarif(prestation, %{})
    render(conn, "edit.html", prestation: prestation, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tarif" => prestation_params}) do
    prestation = Repo.get!(Tarif, id)

    # case Circuit.update_circuit(circuit, circuit_params) do
    case Tarif.changeset(prestation, prestation_params) |> Repo.update() do
      {:ok, prestation} ->
        conn
        |> put_flash(:info, "Préstation mis a jour.")
        |> redirect(to: Routes.tarif_path(conn, :edit, id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", prestation: prestation, changeset: changeset)
    end
  end
end
