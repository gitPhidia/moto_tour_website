defmodule MotoTourWeb.VideosController do
  use MotoTourWeb, :controller
  alias MotoTour.{Repo,Video}
  alias MotoTour.Videos

  def ajout(conn, _params) do
    changeset = Videos.change_video(%Video{})
    liste = Videos.list_Video()
    render(conn, "ajout.html", liste: liste, changeset: changeset)
  end

  def create(conn, %{"video" => video_params}) do
    video_id = extract_video_id(video_params["lien"])
    updated_video_params = Map.put(video_params, "lien", video_id)
    case Videos.create_video(updated_video_params) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "video enregistrer.")
        |> redirect(to: Routes.videos_path(conn, :ajout, video_params))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "ajout.html", changeset: changeset)
    end
  end

  def extract_video_id(url) do
    case Regex.run(~r/(?:v=|\/)([a-zA-Z0-9_-]{11})/, url) do
      [_, video_id] -> video_id
      _ -> nil
    end
  end

  def principal(conn, %{"checkboxes" => checkboxes_params}) do
    import Ecto.Query, only: [from: 2]

    Repo.transaction(fn ->

      # Activer la photo sélectionnée
      Enum.each(checkboxes_params, fn %{"id" => id, "principal" => principal} ->
        id = String.to_integer(id)
        principal = principal == true
        # Désactiver toutes les photos
        Repo.update_all(from(p in Video, where: p.id != ^id), set: [principal: false])

        # if principal do
        Repo.update_all(from(p in Video, where: p.id == ^id), set: [principal: true])
        # end
      end)
    end)

    json(conn, %{status: "success", message: "Mise à jour réussie"})
  end

  def supprimer(conn, %{"id" => id}) do
    video = Videos.video!(id)
    {:ok, _video} = Videos.delete_video(video)

    conn
    |> put_flash(:info, "video supprimer.")
    |> redirect(to: Routes.videos_path(conn, :ajout))
  end

  def edit(conn, %{"id" => id}) do
    video = Videos.video!(id)
    changeset = Videos.change_video(video ,%{})
    render(conn, "edit.html", video: video, changeset: changeset)
  end

  def update(conn, %{"id" => id, "video" => video_params}) do
    video = Videos.video!(id)
    changeset = Videos.change_video(%Video{})

    # case Circuit.update_circuit(circuit, circuit_params) do
    case Video.changeset(video, video_params) |> Repo.update() do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video mis a jour.")
        |> redirect(to: Routes.videos_path(conn, :edit, id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", video: video, changeset: changeset)
    end
  end

end
