defmodule Vision.BoardsTest do
  use Vision.DataCase

  alias Vision.Boards

  describe "boards" do
    alias Vision.Boards.Board

    @valid_attrs %{members: "some members", owner: "some owner", team_name: "some team_name", title: "some title"}
    @update_attrs %{members: "some updated members", owner: "some updated owner", team_name: "some updated team_name", title: "some updated title"}
    @invalid_attrs %{members: nil, owner: nil, team_name: nil, title: nil}

    def board_fixture(attrs \\ %{}) do
      {:ok, board} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Boards.create_board()

      board
    end

    test "list_boards/0 returns all boards" do
      board = board_fixture()
      assert Boards.list_boards() == [board]
    end

    test "get_board!/1 returns the board with given id" do
      board = board_fixture()
      assert Boards.get_board!(board.id) == board
    end

    test "create_board/1 with valid data creates a board" do
      assert {:ok, %Board{} = board} = Boards.create_board(@valid_attrs)
      assert board.members == "some members"
      assert board.owner == "some owner"
      assert board.team_name == "some team_name"
      assert board.title == "some title"
    end

    test "create_board/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Boards.create_board(@invalid_attrs)
    end

    test "update_board/2 with valid data updates the board" do
      board = board_fixture()
      assert {:ok, %Board{} = board} = Boards.update_board(board, @update_attrs)
      assert board.members == "some updated members"
      assert board.owner == "some updated owner"
      assert board.team_name == "some updated team_name"
      assert board.title == "some updated title"
    end

    test "update_board/2 with invalid data returns error changeset" do
      board = board_fixture()
      assert {:error, %Ecto.Changeset{}} = Boards.update_board(board, @invalid_attrs)
      assert board == Boards.get_board!(board.id)
    end

    test "delete_board/1 deletes the board" do
      board = board_fixture()
      assert {:ok, %Board{}} = Boards.delete_board(board)
      assert_raise Ecto.NoResultsError, fn -> Boards.get_board!(board.id) end
    end

    test "change_board/1 returns a board changeset" do
      board = board_fixture()
      assert %Ecto.Changeset{} = Boards.change_board(board)
    end
  end
end
