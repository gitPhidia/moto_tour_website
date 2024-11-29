defmodule MotoTour.ResTest do
  use MotoTour.DataCase

  alias MotoTour.Res

  describe "reservation" do
    alias MotoTour.Res.Reservation

    import MotoTour.ResFixtures

    @invalid_attrs %{}

    test "list_reservation/0 returns all reservation" do
      reservation = reservation_fixture()
      assert Res.list_reservation() == [reservation]
    end

    test "get_reservation!/1 returns the reservation with given id" do
      reservation = reservation_fixture()
      assert Res.get_reservation!(reservation.id) == reservation
    end

    test "create_reservation/1 with valid data creates a reservation" do
      valid_attrs = %{}

      assert {:ok, %Reservation{} = reservation} = Res.create_reservation(valid_attrs)
    end

    test "create_reservation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Res.create_reservation(@invalid_attrs)
    end

    test "update_reservation/2 with valid data updates the reservation" do
      reservation = reservation_fixture()
      update_attrs = %{}

      assert {:ok, %Reservation{} = reservation} = Res.update_reservation(reservation, update_attrs)
    end

    test "update_reservation/2 with invalid data returns error changeset" do
      reservation = reservation_fixture()
      assert {:error, %Ecto.Changeset{}} = Res.update_reservation(reservation, @invalid_attrs)
      assert reservation == Res.get_reservation!(reservation.id)
    end

    test "delete_reservation/1 deletes the reservation" do
      reservation = reservation_fixture()
      assert {:ok, %Reservation{}} = Res.delete_reservation(reservation)
      assert_raise Ecto.NoResultsError, fn -> Res.get_reservation!(reservation.id) end
    end

    test "change_reservation/1 returns a reservation changeset" do
      reservation = reservation_fixture()
      assert %Ecto.Changeset{} = Res.change_reservation(reservation)
    end
  end
end
