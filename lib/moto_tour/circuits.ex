defmodule MotoTour.Circuits do
  alias MotoTour.{Repo,Circuit}


  def list_circuits do
    circuits = Repo.all(Circuit)
  end

  def single_circuit(params) do
    single = Repo.get_by(Circuit, id: params)
    circuit = [single]
  end

  def get_circuit!(id), do: Repo.get!(Circuit, id)

  def update_circuit(%Circuit{} = circuit, attrs) do
    circuit
    |> Circuit.changeset(attrs)
    |> Repo.update()
  end

  def create_circuit(attrs \\ %{}) do
    %Circuit{}
    |> Circuit.changeset(attrs)
    |> Repo.insert()
  end

  def change_circuit(%Circuit{} = circuit, attrs \\ %{}) do
    Circuit.changeset(circuit, attrs)
  end

end
