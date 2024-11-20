defmodule MotoTour.Repo.Migrations.CreateCircuits do
  use Ecto.Migration

  def change do
    create table(:circuits) do
      add :nom, :string
      add :tarifs, :decimal
      add :durée, :string
      add :participant, :integer
      add :moto, :string
      add :difficulté, :string
      add :photo, :string
      add :details, :string
      add :remarque, :string
      add :desc_card, :string

      timestamps()
    end
  end
end
