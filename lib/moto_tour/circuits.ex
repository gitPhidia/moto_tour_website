defmodule MotoTour.Circuits do
  alias MotoTour.{Repo,Circuit}
  import Ecto.Query


  def list_circuits do
    from(c in Circuit, where: c.archiver != true)
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

  def delete_circuit(%circuit{} = circuit) do
    Repo.delete(circuit)
  end

  def archivage(id) do
    # liste = Repo.all(from p in Photo, where: p.idcircuit == ^params)
    from(c in Circuit, where: c.id == ^id)
    |> Repo.update_all(set: [archiver: true])
    # Repo.update(from c in Circuit, where: c.id == ^id, set: [archiver: true])
  end

  def desarchivage(id) do
    # liste = Repo.all(from p in Photo, where: p.idcircuit == ^params)
    from(c in Circuit, where: c.id == ^id)
    |> Repo.update_all(set: [archiver: false])
    # Repo.update(from c in Circuit, where: c.id == ^id, set: [archiver: true])
  end
end
