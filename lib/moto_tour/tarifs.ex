defmodule MotoTour.Tarifs do
  alias MotoTour.{Repo,Tarif}
  import Ecto.Query

  def create_Tarif(attrs \\ %{}) do
    %Tarif{}
    |> Tarif.changeset(attrs)
    |> Repo.insert()
  end

  def list_tarifs(id) do
    query = from(t in Tarif, where: t.idcircuit == ^id)
    Repo.all(query)
  end

  def list_tarifs_idcircuit(id) do
    query = from(t in Tarif, where: t.id == ^id)
    Repo.all(query)
  end

  def delete(%Tarif{} = tarif) do
    Repo.delete(tarif)
  end

  def change_tarif(%Tarif{} = tarif, attrs \\ %{}) do
    Tarif.changeset(tarif, attrs)
  end

end
