defmodule MotoTour.Content.Questions do
  use Ecto.Schema
  import Ecto.Changeset

  schema "question" do
    field :message, :string
    field :idcircuit, :integer
    field :nom, :string
    field :email, :string

    timestamps()
  end

  @doc false
  def changeset(questions, attrs) do
    questions
    |> cast(attrs, [:idcircuit, :nom, :email, :message])
    |> validate_required([:idcircuit, :nom, :email, :message])
  end
end
