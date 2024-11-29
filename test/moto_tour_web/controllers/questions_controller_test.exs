defmodule MotoTourWeb.QuestionsControllerTest do
  use MotoTourWeb.ConnCase

  import MotoTour.ContentFixtures

  @create_attrs %{message: "some message", idcircuit: 42, nom: "some nom", email: "some email"}
  @update_attrs %{message: "some updated message", idcircuit: 43, nom: "some updated nom", email: "some updated email"}
  @invalid_attrs %{message: nil, idcircuit: nil, nom: nil, email: nil}

  describe "index" do
    test "lists all question", %{conn: conn} do
      conn = get(conn, Routes.questions_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Question"
    end
  end

  describe "new questions" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.questions_path(conn, :new))
      assert html_response(conn, 200) =~ "New Questions"
    end
  end

  describe "create questions" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.questions_path(conn, :create), questions: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.questions_path(conn, :show, id)

      conn = get(conn, Routes.questions_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Questions"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.questions_path(conn, :create), questions: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Questions"
    end
  end

  describe "edit questions" do
    setup [:create_questions]

    test "renders form for editing chosen questions", %{conn: conn, questions: questions} do
      conn = get(conn, Routes.questions_path(conn, :edit, questions))
      assert html_response(conn, 200) =~ "Edit Questions"
    end
  end

  describe "update questions" do
    setup [:create_questions]

    test "redirects when data is valid", %{conn: conn, questions: questions} do
      conn = put(conn, Routes.questions_path(conn, :update, questions), questions: @update_attrs)
      assert redirected_to(conn) == Routes.questions_path(conn, :show, questions)

      conn = get(conn, Routes.questions_path(conn, :show, questions))
      assert html_response(conn, 200) =~ "some updated message"
    end

    test "renders errors when data is invalid", %{conn: conn, questions: questions} do
      conn = put(conn, Routes.questions_path(conn, :update, questions), questions: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Questions"
    end
  end

  describe "delete questions" do
    setup [:create_questions]

    test "deletes chosen questions", %{conn: conn, questions: questions} do
      conn = delete(conn, Routes.questions_path(conn, :delete, questions))
      assert redirected_to(conn) == Routes.questions_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.questions_path(conn, :show, questions))
      end
    end
  end

  defp create_questions(_) do
    questions = questions_fixture()
    %{questions: questions}
  end
end
