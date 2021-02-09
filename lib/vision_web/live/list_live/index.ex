defmodule VisionWeb.ListLive.Index do
  use VisionWeb, :live_view

  alias Vision.Boards
  alias Vision.Boards.List

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :lists, list_lists())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit List")
    |> assign(:list, Boards.get_list!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New List")
    |> assign(:list, %List{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Lists")
    |> assign(:list, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    list = Boards.get_list!(id)
    {:ok, _} = Boards.delete_list(list)

    {:noreply, assign(socket, :lists, list_lists())}
  end

  defp list_lists do
    Boards.list_lists()
  end
end
