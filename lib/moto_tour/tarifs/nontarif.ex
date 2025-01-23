defmodule MotoTour.Nontarif do
  use Ecto.Schema
  import Ecto.Changeset

  schema "nontarif" do
    field :prestation, :string
    belongs_to :circuit, MotoTour.Circuit, foreign_key: :idcircuit

    timestamps()
  end

  @doc false
  def changeset(nontarif, attrs) do
    nontarif
    |> cast(attrs, [:prestation, :idcircuit])
    |> validate_required([:prestation])
  end
end
