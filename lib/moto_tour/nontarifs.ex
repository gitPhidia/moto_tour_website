defmodule MotoTour.Nontarifs do
  alias MotoTour.{Repo,Nontarif}
  import Ecto.Query

  def create_Nontarif(attrs \\ %{}) do
    %Nontarif{}
    |> Nontarif.changeset(attrs)
    |> Repo.insert()
  end

  def list_nontarifs(id) do
    query = from(t in Nontarif, where: t.idcircuit == ^id, order_by: t.index)
    Repo.all(query)
  end

  def dernier_ntarifs(id) do
    query = from(t in Nontarif, where: t.idcircuit == ^id, order_by: [desc: t.index], limit: 1)
    Repo.all(query)
  end

  def list_nontarifs_idcircuit(id) do
    query = from(t in Nontarif, where: t.id == ^id)
    Repo.all(query)
  end

  def delete(%Nontarif{} = tarif) do
    Repo.delete(tarif)
  end

  def change_tarif(%Nontarif{} = tarif, attrs \\ %{}) do
    Nontarif.changeset(tarif, attrs)
  end

end
