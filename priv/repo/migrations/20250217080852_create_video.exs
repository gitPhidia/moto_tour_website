defmodule MotoTour.Repo.Migrations.CreateVideo do
  use Ecto.Migration

  def change do
    create table(:video) do
      add :lien, :string
      add :titre, :string
      add :principal, :boolean, default: false, null: false

      timestamps()
    end
  end
end
