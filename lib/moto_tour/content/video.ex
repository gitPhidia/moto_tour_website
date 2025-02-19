defmodule MotoTour.Video do
  use Ecto.Schema
  import Ecto.Changeset

  schema "video" do
    field :lien, :string
    field :titre, :string
    field :principal, :boolean, default: false
    field :index, :integer

    timestamps()
  end

  @doc false
  def changeset(videos, attrs) do
    videos
    |> cast(attrs, [:lien, :titre, :principal, :index])
    |> validate_required([:lien, :titre])
  end
end
