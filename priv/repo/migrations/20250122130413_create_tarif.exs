defmodule MotoTour.Repo.Migrations.CreateTarif do
  use Ecto.Migration

  def change do
    create table(:tarif) do
      add :prestation, :string
      add :idcircuit, :integer

      timestamps()
    end
  end
end
