defmodule MotoTour.Image do
  alias MotoTour.{Repo,Circuit}
  import Ecto.Query
  @moduledoc """
  The Image context.
  """

  import Ecto.Query, warn: false
  alias MotoTour.Repo

  alias MotoTour.Image.Photo

  @doc """
  Returns the list of photos.

  ## Examples

      iex> list_photos()
      [%Photo{}, ...]

  """
  def list_photos do
    Repo.all(Photo)
  end

  def _image do
    query =
      from p in Photo,
        join: c in Circuit, on: c.id == p.idcircuit,
        select: %{
          id: p.id,
          id_circuit: c.id,
          circuit_nom: c.nom,
          nom: p.nom,
          photo: p.photo
        }

    results = Repo.all(query)
  end

  @doc """
  Gets a single photo.

  Raises `Ecto.NoResultsError` if the Photo does not exist.

  ## Examples

      iex> get_photo!(123)
      %Photo{}

      iex> get_photo!(456)
      ** (Ecto.NoResultsError)

  """
  def get_photo!(id), do: Repo.get!(Photo, id)

  def get_photo_circuit(params) do
    liste = Repo.all(from p in Photo, where: p.idcircuit == ^params)
  end

  def get_principal_photos do
    query =
      from p in Photo,
        join: c in Circuit, on: c.id == p.idcircuit,
        where: p.principal == true and c.archiver != true,
        select: %{
          id: p.id,
          idcircuit: c.id,
          circuit_nom: c.nom,
          tarifs: c.tarifs,
          desc_card: c.desc_card,
          difficulté: c.difficulté,
          nom: p.nom,
          photo: p.photo
        }
    results = Repo.all(query)
  end
  @doc """
  Creates a photo.

  ## Examples

      iex> create_photo(%{field: value})
      {:ok, %Photo{}}

      iex> create_photo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_photo(attrs \\ %{}) do
    %Photo{}
    |> Photo.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a photo.

  ## Examples

      iex> update_photo(photo, %{field: new_value})
      {:ok, %Photo{}}

      iex> update_photo(photo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_photo(%Photo{} = photo, attrs) do
    photo
    |> Photo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a photo.

  ## Examples

      iex> delete_photo(photo)
      {:ok, %Photo{}}

      iex> delete_photo(photo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_photo(%Photo{} = photo) do
    Repo.delete(photo)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking photo changes.

  ## Examples

      iex> change_photo(photo)
      %Ecto.Changeset{data: %Photo{}}

  """
  def change_photo(%Photo{} = photo, attrs \\ %{}) do
    Photo.changeset(photo, attrs)
  end
end
