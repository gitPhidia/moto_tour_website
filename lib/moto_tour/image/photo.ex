defmodule MotoTour.Image.Photo do
  use Ecto.Schema
  import Ecto.Changeset
  use Waffle.Ecto.Schema

  schema "photos" do
    field :nom, :string
    field :photo, :string
    field :principal, :boolean
    belongs_to :circuit, MotoTour.Circuit, foreign_key: :idcircuit

    timestamps()
  end

  @doc false
  def changeset(photo, attrs) do
    photo
    |> cast(attrs, [:nom, :idcircuit, :photo, :principal])
    |> validate_required([:photo])
    |> cast_attachments(attrs, [:photo])

  end
end
