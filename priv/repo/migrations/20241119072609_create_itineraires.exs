defmodule MotoTour.Repo.Migrations.CreateItineraires do
  use Ecto.Migration

  def change do
    create table(:itineraires) do
      add :idcircuit, :integer
      add :itineraire, :string
      add :remarque, :string

      timestamps()
    end
  end
end
