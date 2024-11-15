defmodule MotoTour.Circuits do
  alias MotoTour.{Repo,Circuit}

  def list_circuits do
    circuits = Repo.all(Circuit)
  end

end
