defmodule MotoTour.Itineraires do
  alias MotoTour.{Repo,Itineraire}

  def list_itineraire do
    itineraire = Repo.all(Itineraire)
  end

  def single_itineraire(params) do
    single = Repo.get_by(Itineraire, id: params)
    itineraire = [single]
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

end
