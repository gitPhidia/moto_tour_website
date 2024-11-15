defmodule MotoTour.Repo.Migrations.CreateCircuits do
  use Ecto.Migration

  def change do
    create table(:circuits) do
      add :Tarifs, :decimal
      add :durée, :string
      add :participant, :integer
      add :moto, :string
      add :difficulté, :string
      add :photo, :string
      add :details, :string
      add :remarque, :string

      timestamps()
    end
  end
end
