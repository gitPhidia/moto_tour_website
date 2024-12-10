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

  def create(conn, %{"photo" => %{"nom" => nom, "idcircuit" => idcircuit, "photo" => %Plug.Upload{path: temp_path, filename: filename}}}) do
    upload_dir = "priv/static/assets/images/section/circuit_image"
    upload_path = Path.join([upload_dir, filename])

    # Vérifications
    IO.inspect(temp_path, label: "Chemin temporaire")
    IO.inspect(upload_path, label: "Chemin cible")

    # File.mkdir_p!(upload_dir)

    case File.cp(temp_path, upload_path) do
      :ok ->
        changeset = Photo.changeset(%Photo{}, %{nom: nom, idcircuit: idcircuit, photo: filename})

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
  rescue
    e in RuntimeError ->
      IO.inspect(e, label: "Erreur")
      conn
      |> put_flash(:error, "Erreur inattendue : #{inspect(e)}")
      |> redirect(to: Routes.photo_path(conn, :new))
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
    {:ok, _photo} = Image.delete_photo(photo)

    conn
    |> put_flash(:info, "Photo deleted successfully.")
    |> redirect(to: Routes.photo_path(conn, :index))
  end
end
