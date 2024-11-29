defmodule MotoTourWeb.QuestionsController do
  use MotoTourWeb, :controller

  alias MotoTour.Content
  alias MotoTour.Content.Questions

  def index(conn, _params) do
    question = Content.list_question()
    render(conn, "index.html", question: question)
  end

  def new(conn, _params) do
    changeset = Content.change_questions(%Questions{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"questions" => questions_params}) do
    case Content.create_questions(questions_params) do
      {:ok, questions} ->
        conn
        |> put_flash(:info, "Questions created successfully.")
        |> redirect(to: Routes.questions_path(conn, :show, questions))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    questions = Content.get_questions!(id)
    render(conn, "show.html", questions: questions)
  end

  def edit(conn, %{"id" => id}) do
    questions = Content.get_questions!(id)
    changeset = Content.change_questions(questions)
    render(conn, "edit.html", questions: questions, changeset: changeset)
  end

  def update(conn, %{"id" => id, "questions" => questions_params}) do
    questions = Content.get_questions!(id)

    case Content.update_questions(questions, questions_params) do
      {:ok, questions} ->
        conn
        |> put_flash(:info, "Questions updated successfully.")
        |> redirect(to: Routes.questions_path(conn, :show, questions))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", questions: questions, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    questions = Content.get_questions!(id)
    {:ok, _questions} = Content.delete_questions(questions)

    conn
    |> put_flash(:info, "Questions deleted successfully.")
    |> redirect(to: Routes.questions_path(conn, :index))
  end
end
