defmodule MotoTour.Reservations do
  alias MotoTour.{Repo,Reservation}
  alias MotoTour.{Repo,Circuit}
  import Ecto.Query

  def list_res do
    res = Repo.all(Reservation)
  end

  def _res do
    query =
      from r in Reservation,
        join: c in Circuit, on: c.id == r.idcircuit,
        select: %{
          circuit_nom: c.nom,
          nom: r.nom,
          email: r.email,
          telephone: r.telephone,
          participant: r.participant,
          date_res: r.date_res,
          besoin: r.besoin,
          inserted_at: r.inserted_at
        }

    results = Repo.all(query)
  end
end
