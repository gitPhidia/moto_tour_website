defmodule MotoTourWeb.PhotoController do
  use MotoTourWeb, :controller

  alias MotoTour.Image
  alias MotoTour.Image.Photo
  alias MotoTour.{Repo,Circuit}
  alias MotoTour.Circuits
  alias Plug.Upload
  import Ecto.Query

  def index(conn, _params) do
    # photos = Image._image()
    circuit = Circuits.list_circuits()
    render(conn, "tableau.html", circuits: circuit)
  end

  def detail(conn,  %{"id" => id}) do
    photo = Image.get_photo_circuit(id)
    render(conn, "index.html", photos: photo)
  end

  def new(conn, _params) do
    query = from c in Circuit,
      select: %{ id: c.id, nom: c.nom}
    cir = Repo.all(query)
    circuit_options = Enum.map(cir, fn c -> {c.nom, c.id} end)
    changeset = Image.change_photo(%Photo{})
    render(conn, "new.html", changeset: changeset, circuit: circuit_options)
  end

  def create(conn, %{"photo" => photo_params}) do
    upload_dir = "priv/static/assets/images/section/circuit_image"

    # Extraire les champs avec des valeurs par défaut pour éviter les erreurs
    nom = Map.get(photo_params, "nom", "")
    idcircuit = Map.get(photo_params, "idcircuit", "")
    photo = Map.get(photo_params, "photo", nil)

    # Vérification des champs vides
    cond do
      nom == "" or idcircuit == "" or is_nil(photo) ->
        conn
        |> put_flash(:error, "Tous les champs sont obligatoires.")
        |> redirect(to: Routes.photo_path(conn, :new))

      not is_map(photo) or not Map.has_key?(photo, :path) or not Map.has_key?(photo, :filename) ->
        conn
        |> put_flash(:error, "Le fichier photo est invalide.")
        |> redirect(to: Routes.photo_path(conn, :new))

      not valid_extension?(photo.filename) ->
        conn
        |> put_flash(:error, "Seuls les fichiers JPEG et PNG sont autorisés.")
        |> redirect(to: Routes.photo_path(conn, :new))

      true ->
        # Si les champs sont valides, on procède au traitement
        %Plug.Upload{path: temp_path, filename: filename} = photo
        upload_path = Path.join([upload_dir, filename])

        # Créer un changeset pour validation
        changeset = Photo.changeset(%Photo{}, %{nom: nom, idcircuit: idcircuit, photo: filename})

        if changeset.valid? do
          case File.cp(temp_path, upload_path) do
            :ok ->
              case Repo.insert(changeset) do
                {:ok, _photo} ->
                  conn
                  |> put_flash(:info, "Photo uploadée avec succès !")
                  |> redirect(to: Routes.photo_path(conn, :new))

                {:error, changeset} ->
                  conn
                  |> put_flash(:error, "Erreur lors de l'enregistrement de la photo.")
                  |> render("new.html", changeset: changeset)
              end

            {:error, reason} ->
              conn
              |> put_flash(:error, "Erreur lors de la copie du fichier : #{reason}")
              |> redirect(to: Routes.photo_path(conn, :new))
          end
        else
          conn
          |> put_flash(:error, "Certains champs sont invalides. Veuillez les vérifier.")
          |> render("new.html", changeset: changeset)
        end
    end
  rescue
    e in RuntimeError ->
      IO.inspect(e, label: "Erreur")
      conn
      |> put_flash(:error, "Erreur inattendue : #{inspect(e)}")
      |> redirect(to: Routes.photo_path(conn, :new))
  end

    # Fonction pour valider les extensions de fichier
  defp valid_extension?(filename) do
    String.ends_with?(filename, [".jpg", ".jpeg", ".png"])
  end

  def show(conn, %{"id" => id}) do
    photo = Image.get_photo!(id)
    render(conn, "show.html", photo: photo)
  end

  def edit(conn, %{"id" => id}) do
    photo = Image.get_photo!(id)
    changeset = Image.change_photo(photo)
    render(conn, "edit.html", photo: photo, changeset: changeset)
  end

  def update(conn, %{"id" => id, "photo" => photo_params}) do
    photo = Image.get_photo!(id)

    case Image.update_photo(photo, photo_params) do
      {:ok, photo} ->
        conn
        |> put_flash(:info, "Photo updated successfully.")
        |> redirect(to: Routes.photo_path(conn, :show, photo))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", photo: photo, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    photo = Image.get_photo!(id)
    idcircuit = photo.idcircuit
    {:ok, _photo} = Image.delete_photo(photo)

    conn
    |> put_flash(:info, "Photo deleted successfully.")
    |> redirect(to: Routes.photo_path(conn, :detail, idcircuit))
  end

  def principal(conn, %{"checkboxes" => checkboxes_params}) do
    import Ecto.Query, only: [from: 2]

    Repo.transaction(fn ->

      # Activer la photo sélectionnée
      Enum.each(checkboxes_params, fn %{"id" => id, "idcircuit" => idcircuit, "principal" => principal} ->
        id = String.to_integer(id)
        principal = principal == true
        idcircuit = String.to_integer(idcircuit)
        # Désactiver toutes les photos
        Repo.update_all(from(p in Photo, where: p.idcircuit == ^idcircuit), set: [principal: false])

        # if principal do
          Repo.update_all(from(p in Photo, where: p.id == ^id), set: [principal: true])
        # end
      end)
    end)

    json(conn, %{status: "success", message: "Mise à jour réussie"})
  end
end
