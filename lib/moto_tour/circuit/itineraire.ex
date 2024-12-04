defmodule MotoTour.Itineraire do
  use Ecto.Schema
  import Ecto.Changeset

  schema "itineraires" do
    field :itineraire, :string
    field :remarque, :string
    belongs_to :circuit, MotoTour.Circuit, foreign_key: :idcircuit

    timestamps()
  end

  @doc false
  def changeset(itineraire, attrs) do
    itineraire
    |> cast(attrs, [:idcircuit, :itineraire, :remarque])
    |> validate_required([:idcircuit, :itineraire, :remarque])
  end
end
