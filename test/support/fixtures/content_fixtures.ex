defmodule MotoTour.ContentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MotoTour.Content` context.
  """

  @doc """
  Generate a questions.
  """
  def questions_fixture(attrs \\ %{}) do
    {:ok, questions} =
      attrs
      |> Enum.into(%{
        message: "some message",
        idcircuit: 42,
        nom: "some nom",
        email: "some email"
      })
      |> MotoTour.Content.create_questions()

    questions
  end
end
