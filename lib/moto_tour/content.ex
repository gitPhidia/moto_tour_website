defmodule MotoTour.Content do
  @moduledoc """
  The Content context.
  """

  import Ecto.Query, warn: false
  alias MotoTour.Repo

  alias MotoTour.Content.Questions

  @doc """
  Returns the list of question.

  ## Examples

      iex> list_question()
      [%Questions{}, ...]

  """
  def list_question do
    Repo.all(Questions)
  end

  @doc """
  Gets a single questions.

  Raises `Ecto.NoResultsError` if the Questions does not exist.

  ## Examples

      iex> get_questions!(123)
      %Questions{}

      iex> get_questions!(456)
      ** (Ecto.NoResultsError)

  """
  def get_questions!(id), do: Repo.get!(Questions, id)

  @doc """
  Creates a questions.

  ## Examples

      iex> create_questions(%{field: value})
      {:ok, %Questions{}}

      iex> create_questions(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_questions(attrs \\ %{}) do
    %Questions{}
    |> Questions.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a questions.

  ## Examples

      iex> update_questions(questions, %{field: new_value})
      {:ok, %Questions{}}

      iex> update_questions(questions, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_questions(%Questions{} = questions, attrs) do
    questions
    |> Questions.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a questions.

  ## Examples

      iex> delete_questions(questions)
      {:ok, %Questions{}}

      iex> delete_questions(questions)
      {:error, %Ecto.Changeset{}}

  """
  def delete_questions(%Questions{} = questions) do
    Repo.delete(questions)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking questions changes.

  ## Examples

      iex> change_questions(questions)
      %Ecto.Changeset{data: %Questions{}}

  """
  def change_questions(%Questions{} = questions, attrs \\ %{}) do
    Questions.changeset(questions, attrs)
  end
end
