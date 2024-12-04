defmodule MotoTour.ImageTest do
  use MotoTour.DataCase

  alias MotoTour.Image

  describe "photos" do
    alias MotoTour.Image.Photo

    import MotoTour.ImageFixtures

    @invalid_attrs %{nom: nil, idcircuit: nil}

    test "list_photos/0 returns all photos" do
      photo = photo_fixture()
      assert Image.list_photos() == [photo]
    end

    test "get_photo!/1 returns the photo with given id" do
      photo = photo_fixture()
      assert Image.get_photo!(photo.id) == photo
    end

    test "create_photo/1 with valid data creates a photo" do
      valid_attrs = %{nom: "some nom", idcircuit: 42}

      assert {:ok, %Photo{} = photo} = Image.create_photo(valid_attrs)
      assert photo.nom == "some nom"
      assert photo.idcircuit == 42
    end

    test "create_photo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Image.create_photo(@invalid_attrs)
    end

    test "update_photo/2 with valid data updates the photo" do
      photo = photo_fixture()
      update_attrs = %{nom: "some updated nom", idcircuit: 43}

      assert {:ok, %Photo{} = photo} = Image.update_photo(photo, update_attrs)
      assert photo.nom == "some updated nom"
      assert photo.idcircuit == 43
    end

    test "update_photo/2 with invalid data returns error changeset" do
      photo = photo_fixture()
      assert {:error, %Ecto.Changeset{}} = Image.update_photo(photo, @invalid_attrs)
      assert photo == Image.get_photo!(photo.id)
    end

    test "delete_photo/1 deletes the photo" do
      photo = photo_fixture()
      assert {:ok, %Photo{}} = Image.delete_photo(photo)
      assert_raise Ecto.NoResultsError, fn -> Image.get_photo!(photo.id) end
    end

    test "change_photo/1 returns a photo changeset" do
      photo = photo_fixture()
      assert %Ecto.Changeset{} = Image.change_photo(photo)
    end
  end
end
