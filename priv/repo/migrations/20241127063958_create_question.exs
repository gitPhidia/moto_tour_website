defmodule MotoTour.Repo.Migrations.CreateQuestion do
  use Ecto.Migration

  def change do
    create table(:question) do
      add :idcircuit, :integer
      add :nom, :string
      add :email, :string
      add :message, :text

      timestamps()
    end
  end
end
