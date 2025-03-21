defmodule MotoTour.Circuits do
  alias MotoTour.{Repo,Circuit}
  import Ecto.Query


  def list_circuits do
    query = from(c in Circuit, where: is_nil(c.archiver) or c.archiver == false, order_by: c.id)
    circuits = Repo.all(query)
  end

  def list_circuits_back do
    query = from(c in Circuit, order_by: c.id)
    circuits = Repo.all(query)
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

  def delete_circuit(%Circuit{} = circuit) do
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

  def get_adjacent_circuits(id) do
    query = """
      SELECT * FROM (
          SELECT
              LAG(id) OVER (order by id) AS previous_id,
              id AS current_id,
              LEAD(id) OVER (order by id) AS next_id
          FROM circuits
      ) AS subquery
      WHERE current_id = $1
    """

    case Ecto.Adapters.SQL.query(Repo, query, [id]) do
      {:ok, %Postgrex.Result{columns: columns, rows: [row]}} ->
        # Map the result to a keyword list or map for easier access
        Enum.zip(columns, row) |> Enum.into(%{})

      {:ok, %Postgrex.Result{rows: []}} ->
        {:error, "No circuit found with the given id"}

      {:error, reason} ->
        {:error, reason}
    end
  end

end
