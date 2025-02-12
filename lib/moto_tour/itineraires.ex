defmodule MotoTour.Itineraires do
  alias MotoTour.{Repo,Itineraire}
  import Ecto.Query

  def list_itineraire do
    query = from(c in Itineraire, order_by: c.numero)
    # itineraire = Repo.all(Itineraire)
    itineraire = Repo.all(query)
  end

  def single_itineraire(params) do
    single = Repo.get_by(Itineraire, id: params)
    # itineraire = [single]
  end

  def verification(numero, idcircuit) do
    query = from(c in Itineraire, where: c.numero == ^numero and c.idcircuit == ^idcircuit)
    itineraire = Repo.all(query)
  end

  def verification_edit(numero, idcircuit, id) do
    query = from(c in Itineraire, where: c.numero == ^numero and c.idcircuit == ^idcircuit and c.id != ^id)
    itineraire = Repo.all(query)
  end

  def itineraire_circuit(params) do
    liste = Repo.get_by(Itineraire, idcircuit: params)
  end

  def change_itineraire(%Itineraire{} = itineraire, attrs \\ %{}) do
    Itineraire.changeset(itineraire, attrs)
  end

  def create_itineraire(attrs \\ %{}) do
    %Itineraire{}
    |> Itineraire.changeset(attrs)
    |> Repo.insert()
  end

  def delete_itineraire(%Itineraire{} = itineraire) do
    Repo.delete(itineraire)
  end

  def supprimer_par_numero(numero, idcircuit) do
    from(i in Itineraire, where: i.numero == ^numero and i.idcircuit == ^idcircuit)
    |> Repo.delete_all()
  end

  def etape_par_numero(numero, idcircuit) do
    query = from(i in Itineraire, where: i.numero == ^numero and i.idcircuit == ^idcircuit)
    itineraire = Repo.all(query)
  end

end
