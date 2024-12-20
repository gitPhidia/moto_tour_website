defmodule MotoTourWeb.QuestionsController do
  use MotoTourWeb, :controller

  alias MotoTour.Content
  alias MotoTour.Content.Questions

  def new(conn, _params) do
    changeset = Content.change_questions(%Questions{})
    render(conn, "contact.html", changeset: changeset)
  end

  def index(conn, _params) do
    question = Content.list_question()
    render(conn, "index.html", question: question)
  end

  def create(conn, %{"questions" => questions_params}) do
    case Content.create_questions(questions_params) do
      {:ok, questions} ->
        conn
        |> put_flash(:info, "Questions created successfully.")
        |> redirect(to: Routes.questions_path(conn, :new))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "contact.html", changeset: changeset)
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

  def download_csv(conn, _params) do
    file_path = "priv/static/assets/export.csv"

    # Exporter les données
    Content.export_data_to_csv(file_path)

    # Envoyer le fichier en réponse
    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"export.csv\"")
    |> send_file(200, file_path)
  end
end
