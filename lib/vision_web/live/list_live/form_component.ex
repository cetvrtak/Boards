defmodule VisionWeb.ListLive.FormComponent do
  use VisionWeb, :live_component

  alias Vision.Boards

  @impl true
  def update(%{list: list} = assigns, socket) do
    changeset = Boards.change_list(list)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"list" => list_params}, socket) do
    changeset =
      socket.assigns.list
      |> Boards.change_list(list_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"list" => list_params}, socket) do
    save_list(socket, socket.assigns.action, list_params)
  end

  defp save_list(socket, :edit, list_params) do
    case Boards.update_list(socket.assigns.list, list_params) do
      {:ok, _list} ->
        {:noreply,
         socket
         |> put_flash(:info, "List updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_list(socket, :new, list_params) do
    case Boards.create_list(list_params) do
      {:ok, _list} ->
        {:noreply,
         socket
         |> put_flash(:info, "List created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
