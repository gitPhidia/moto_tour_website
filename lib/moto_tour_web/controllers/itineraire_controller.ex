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
    circuit = Circuits.get_circuit!(id)
    second_card_content = Itineraires.list_itineraire()
    filtered_content = Enum.filter(second_card_content, fn c -> c.idcircuit == String.to_integer(id) end)
    render(conn, "liste.html", itineraire: filtered_content, circuit: circuit)
  end

  def ajout(conn, %{"id" => id}) do
    # query = from c in Circuit,
    #   select: %{ id: c.id, nom: c.nom}
    # cir = Repo.all(query)
    circuit = Circuits.get_circuit!(id)
    # circuits_options = Enum.map(cir, fn c -> {c.nom, c.id} end)
    changeset = Itineraires.change_itineraire(%Itineraire{})
    render(conn, "new.html", circuits: circuit, changeset: changeset, id: id)
  end

  def create(conn, %{"itineraire" => itineraire_params}) do
    required_fields = ["idcircuit", "remarque"]

    # Vérification des champs vides
    missing_fields = Enum.filter(required_fields, fn field -> Map.get(itineraire_params, field) in [nil, ""] end)

    if missing_fields != [] do
      conn
      |> put_flash(:error, "Les champs suivants sont requis : #{Enum.join(missing_fields, ", ")}.")
      |> redirect(to: Routes.itineraire_path(conn, :ajout, itineraire_params["idcircuit"]))
    else
      changeset = Itineraires.change_itineraire(%Itineraire{}, itineraire_params)

      if changeset.valid? do
        case Itineraires.create_itineraire(itineraire_params) do
          {:ok, itineraire} ->
            conn
            |> put_flash(:info, "Itinéraire ajouté.")
            |> redirect(to: Routes.itineraire_path(conn, :ajout, itineraire.idcircuit))

          {:error, %Ecto.Changeset{} = changeset} ->
            conn
            |> put_flash(:error, "Une erreur est survenue lors de l'ajout.")
            |> redirect(to: Routes.itineraire_path(conn, :ajout, itineraire_params["idcircuit"]))
        end
      else
        conn
        |> put_flash(:error, "Certains champs sont invalides.")
        |> redirect(to: Routes.itineraire_path(conn, :ajout, itineraire_params["idcircuit"]))
      end
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
