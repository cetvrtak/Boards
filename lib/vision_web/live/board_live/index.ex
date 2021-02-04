defmodule VisionWeb.BoardLive.Index do
  use VisionWeb, :live_view
  import Boards.Authorization

  alias Vision.Boards
  alias Vision.Boards.Board

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :boards, list_boards())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Board")
    |> assign(:board, Boards.get_board!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Board")
    |> assign(:board, %Board{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Boards")
    |> assign(:board, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    #role = socket.assigns.current_user.role

    board = Boards.get_board!(id)

    #with true <- can(role) |> delete?(Board) do
      {:ok, _} = Boards.delete_board(board)

      {:noreply, assign(socket, :boards, list_boards())}
    #else
    #  false ->
    #    {:noreply, put_flash(socket, :error, "You're not authorized to do this!")}
    #end
  end

  defp list_boards do
    Boards.list_boards()
  end
end
