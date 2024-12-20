defmodule MotoTour.Content.Questions do
  use Ecto.Schema
  import Ecto.Changeset

  schema "question" do
    field :message, :string
    field :nom, :string
    field :email, :string
    field :telephone, :string

    timestamps()
  end

  @doc false
  def changeset(questions, attrs) do
    questions
    |> cast(attrs, [ :nom, :email, :message, :telephone])
    |> validate_required([ :nom, :email, :message, :telephone])
  end
end
