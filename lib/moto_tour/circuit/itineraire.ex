defmodule MotoTour.Itineraire do
  use Ecto.Schema
  import Ecto.Changeset

  schema "itineraires" do
    field :jour, :integer
    field :depart, :string
    field :arriver, :string
    field :distance, :string
    field :itineraire, :string
    field :remarque, :string
    belongs_to :circuit, MotoTour.Circuit, foreign_key: :idcircuit

    timestamps()
  end

  @doc false
  def changeset(itineraire, attrs) do
    itineraire
    |> cast(attrs, [:idcircuit, :jour, :depart, :arriver, :itineraire, :remarque, :distance])
    |> validate_required([:idcircuit, :remarque])
  end
end
