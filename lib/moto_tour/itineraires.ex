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
    itineraire = [liste]
  end

end
