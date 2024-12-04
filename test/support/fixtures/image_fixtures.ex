defmodule MotoTour.ImageFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MotoTour.Image` context.
  """

  @doc """
  Generate a photo.
  """
  def photo_fixture(attrs \\ %{}) do
    {:ok, photo} =
      attrs
      |> Enum.into(%{
        nom: "some nom",
        idcircuit: 42
      })
      |> MotoTour.Image.create_photo()

    photo
  end
end
