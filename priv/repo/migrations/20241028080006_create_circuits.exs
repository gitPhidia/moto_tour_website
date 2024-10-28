defmodule MotoTour.Repo.Migrations.CreateCircuits do
  use Ecto.Migration

  def change do
    create table(:circuits) do
      add :tarifs, :integer
      add :parcours, :string
      add :duree, :naive_datetime
      add :itineraire, :string
      add :nbr_max, :integer
      add :moto, :text
      add :difficulte, :string
      add :remarque, :text
      add :photo, :string
      add :details, :text

      timestamps()
    end
  end
end
