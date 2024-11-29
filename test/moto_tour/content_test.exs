defmodule MotoTour.ContentTest do
  use MotoTour.DataCase

  alias MotoTour.Content

  describe "question" do
    alias MotoTour.Content.Questions

    import MotoTour.ContentFixtures

    @invalid_attrs %{message: nil, idcircuit: nil, nom: nil, email: nil}

    test "list_question/0 returns all question" do
      questions = questions_fixture()
      assert Content.list_question() == [questions]
    end

    test "get_questions!/1 returns the questions with given id" do
      questions = questions_fixture()
      assert Content.get_questions!(questions.id) == questions
    end

    test "create_questions/1 with valid data creates a questions" do
      valid_attrs = %{message: "some message", idcircuit: 42, nom: "some nom", email: "some email"}

      assert {:ok, %Questions{} = questions} = Content.create_questions(valid_attrs)
      assert questions.message == "some message"
      assert questions.idcircuit == 42
      assert questions.nom == "some nom"
      assert questions.email == "some email"
    end

    test "create_questions/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_questions(@invalid_attrs)
    end

    test "update_questions/2 with valid data updates the questions" do
      questions = questions_fixture()
      update_attrs = %{message: "some updated message", idcircuit: 43, nom: "some updated nom", email: "some updated email"}

      assert {:ok, %Questions{} = questions} = Content.update_questions(questions, update_attrs)
      assert questions.message == "some updated message"
      assert questions.idcircuit == 43
      assert questions.nom == "some updated nom"
      assert questions.email == "some updated email"
    end

    test "update_questions/2 with invalid data returns error changeset" do
      questions = questions_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_questions(questions, @invalid_attrs)
      assert questions == Content.get_questions!(questions.id)
    end

    test "delete_questions/1 deletes the questions" do
      questions = questions_fixture()
      assert {:ok, %Questions{}} = Content.delete_questions(questions)
      assert_raise Ecto.NoResultsError, fn -> Content.get_questions!(questions.id) end
    end

    test "change_questions/1 returns a questions changeset" do
      questions = questions_fixture()
      assert %Ecto.Changeset{} = Content.change_questions(questions)
    end
  end
end
