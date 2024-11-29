defmodule MotoTour.Repo.Migrations.CreateReservations do
  use Ecto.Migration

  def change do
    create table(:reservations) do
      add :idcircuit, :integer
      add :nom, :string
      add :email, :string
      add :telephone, :string
      add :participant, :integer
      add :date_res, :date
      add :besoin, :text
      add :archivage, :integer
      add :validation, :integer

      timestamps()
    end
  end
end
