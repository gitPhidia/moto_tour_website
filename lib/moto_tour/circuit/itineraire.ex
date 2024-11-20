defmodule MotoTour.Itineraire do
  use Ecto.Schema
  import Ecto.Changeset

  schema "itineraires" do
    field :idcircuit, :integer
    field :itineraire, :string
    field :remarque, :string

    timestamps()
  end

  @doc false
  def changeset(itineraire, attrs) do
    itineraire
    |> cast(attrs, [:idcircuit, :itineraire, :remarque])
    |> validate_required([:idcircuit, :itineraire, :remarque])
  end
end
