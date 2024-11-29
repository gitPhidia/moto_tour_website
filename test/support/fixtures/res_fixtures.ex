defmodule MotoTour.ResFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MotoTour.Res` context.
  """

  @doc """
  Generate a reservation.
  """
  def reservation_fixture(attrs \\ %{}) do
    {:ok, reservation} =
      attrs
      |> Enum.into(%{

      })
      |> MotoTour.Res.create_reservation()

    reservation
  end
end
