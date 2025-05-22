defmodule MotoTourWeb.NontarifController do
  use MotoTourWeb, :controller
  alias MotoTour.{Repo,Nontarif}
  alias MotoTour.Nontarifs

  def edit(conn, %{"id" => id}) do
    prestation = Repo.get!(Nontarif, id)
    changeset = Nontarifs.change_tarif(prestation, %{})
    render(conn, "edit.html", prestation: prestation, changeset: changeset)
  end

  def update(conn, %{"id" => id, "nontarif" => prestation_params}) do
    prestation = Repo.get!(Nontarif, id)

    # case Circuit.update_circuit(circuit, circuit_params) do
    case Nontarif.changeset(prestation, prestation_params) |> Repo.update() do
      {:ok, prestation} ->
        conn
        |> put_flash(:info, "Préstation mis a jour.")
        |> redirect(to: Routes.nontarif_path(conn, :edit, id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", prestation: prestation, changeset: changeset)
    end
  end

end
