defmodule MotoTour.Circuit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "circuits" do
    field :details, :string
    field :difficulte, :string
    field :duree, :naive_datetime
    field :itineraire, :string
    field :moto, :string
    field :nbr_max, :integer
    field :parcours, :string
    field :photo, :string
    field :remarque, :string
    field :tarifs, :integer

    timestamps()
  end

  @doc false
  def changeset(circuit, attrs) do
    circuit
    |> cast(attrs, [:tarifs, :parcours, :duree, :itineraire, :nbr_max, :moto, :difficulte, :remarque, :photo, :details])
    |> validate_required([:tarifs, :parcours, :duree, :itineraire, :nbr_max, :moto, :difficulte, :remarque, :photo, :details])
  end
end
