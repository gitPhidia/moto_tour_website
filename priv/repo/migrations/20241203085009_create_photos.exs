defmodule MotoTour.Repo.Migrations.CreatePhotos do
  use Ecto.Migration

  def change do
    create table(:photos) do
      add :nom, :string
      add :idcircuit, :integer

      timestamps()
    end
  end
end
