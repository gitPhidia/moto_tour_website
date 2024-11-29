defmodule MotoTour.Reservation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reservations" do
    field :participant, :integer
    field :nom, :string
    field :email, :string
    field :telephone, :string
    field :date_res, :date
    field :besoin, :string
    field :archivage, :integer
    field :validation, :integer
    belongs_to :circuit, MotoTour.Circuit, foreign_key: :idcircuit

    timestamps()
  end

  @doc false
  def changeset(reservation, attrs) do
    reservation
    |> cast(attrs, [:idcircuit, :nom, :email, :telephone, :participant, :date_res, :besoin, :archivage, :validation])
    |> validate_required([:idcircuit, :nom, :email, :telephone, :participant, :date_res, :besoin, :archivage, :validation])
  end
end
