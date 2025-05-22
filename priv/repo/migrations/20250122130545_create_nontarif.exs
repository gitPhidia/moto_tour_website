defmodule MotoTour.Repo.Migrations.CreateNontarif do
  use Ecto.Migration

  def change do
    create table(:nontarif) do
      add :prestation, :string
      add :idcircuit, :integer

      timestamps()
    end
  end
end
