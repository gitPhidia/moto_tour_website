defmodule MotoTourWeb.ItineraireController do
  use MotoTourWeb, :controller
  alias MotoTour.{Repo,Circuit}
  alias MotoTour.Circuits
  alias MotoTour.Itineraires
  alias MotoTour.Itineraire
  import Ecto.Query

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
    query = from c in Circuit,
      select: %{ id: c.id, nom: c.nom}
    cir = Repo.all(query)
    circuits_options = Enum.map(cir, fn c -> {c.nom, c.id} end)
    changeset = Itineraires.change_itineraire(%Itineraire{})
    render(conn, "new.html", circuits: circuits_options, changeset: changeset)
  end

  def create(conn, %{"itineraire" => itineraire}) do
    changeset = Itineraires.change_itineraire(%Itineraire{}, itineraire)

    if changeset.valid? do
      case Itineraires.create_itineraire(itineraire) do
        {:ok, itineraire} ->
          conn
          |> put_flash(:info, "itineraire ajouter.")
          |> redirect(to: Routes.itineraire_path(conn, :ajout))

        {:error, %Ecto.Changeset{} = changeset} ->
          conn
          |> put_flash(:error, "Une erreur est survenue lors de l'ajout.")
          |> redirect(to: Routes.itineraire_path(conn, :ajout))
          # |> render(conn, "new.html", changeset: changeset)
      end
    else
      # Si des champs sont vides, on reste sur la page "new" avec un message d'erreur
      conn
      |> put_flash(:error, "Certains champs sont vides. Veuillez les remplir.")
      |> redirect(to: Routes.itineraire_path(conn, :ajout))
      # |> render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    itineraire = Itineraires.single_itineraire(id)
    changeset = Itineraires.change_itineraire(itineraire, %{})
    render(conn, "edit.html", itineraire: itineraire, changeset: changeset)
  end

  def update(conn, %{"id" => id, "itineraire" => itineraire_params}) do
    itineraire = Itineraires.single_itineraire(id)

    # case Circuit.update_circuit(circuit, circuit_params) do
    case Itineraire.changeset(itineraire, itineraire_params) |> Repo.update() do
      {:ok, itineraire} ->
        conn
        |> put_flash(:info, "Itineraire mis a jour.")
        |> redirect(to: Routes.itineraire_path(conn, :edit, id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", itineraire: itineraire, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    itineraire = Itineraires.single_itineraire(id)
    idcircuit = itineraire.idcircuit
    IO.inspect(idcircuit, label: "Paramètres reçus")
    {:ok, _itineraire} = Itineraires.delete_itineraire(itineraire)

    conn
    |> put_flash(:info, "itineraire supprimer avec succées.")
    |> redirect(to: Routes.itineraire_path(conn, :liste, idcircuit))
  end

end
