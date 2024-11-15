defmodule MotoTour.Circuit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "circuits" do
    field :nom, :string
    field :participant, :integer
    field :details, :string
    field :tarifs, :decimal
    field :durée, :string
    field :moto, :string
    field :difficulté, :string
    field :photo, :string
    field :remarque, :string

    timestamps()
  end

  @doc false
  def changeset(circuit, attrs) do
    circuit
    |> cast(attrs, [:nom,:tarifs, :durée, :participant, :moto, :difficulté, :photo, :details, :remarque])
    |> validate_required([:nom,:tarifs, :durée, :participant, :moto, :difficulté, :photo, :details, :remarque])
  end
end