defmodule MotoTour.Videos do
  alias MotoTour.{Repo,Video}
  import Ecto.Query

  def create_video(attrs \\ %{}) do
    %Video{}
    |> Video.changeset(attrs)
    |> Repo.insert()
  end

  def list_Video() do
    query = from(t in Video, order_by: t.index)
    Repo.all(query)
  end

  def principal() do
    query = from(t in Video, where: t.principal == true, limit: 1)
    Repo.one(query)
  end

  def video_select(lien) do
    query = from(t in Video, where: t.lien == ^lien, limit: 1)
    Repo.one(query)
  end

  def video!(id) do
    query = from(t in Video, where: t.id == ^id, limit: 1)
    Repo.one(query)
  end

  def delete_video(%Video{} = video) do
    Repo.delete(video)
  end

  def dernier_index() do
    query = from(t in Video, order_by: [desc: t.id], limit: 1)
    Repo.all(query)
  end

  def change_video(%Video{} = video, attrs \\ %{}) do
    Video.changeset(video, attrs)
  end
end
