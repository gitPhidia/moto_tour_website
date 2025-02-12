defmodule MotoTour.Tarif do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tarif" do
    field :prestation, :string
    field :index, :integer
    belongs_to :circuit, MotoTour.Circuit, foreign_key: :idcircuit

    timestamps()
  end

  @doc false
  def changeset(tarif, attrs) do
    tarif
    |> cast(attrs, [:prestation, :idcircuit, :index])
    |> validate_required([:prestation])
  end
end
