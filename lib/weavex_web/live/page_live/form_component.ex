defmodule WeavexWeb.PageLive.FormComponent do
  use WeavexWeb, :live_component

  alias Weavex.Blog

  @impl true
  def update(%{page: page} = assigns, socket) do
    changeset = Blog.change_page(page)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"page" => page_params}, socket) do
    changeset =
      socket.assigns.page
      |> Blog.change_page(page_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"page" => page_params}, socket) do
    save_page(socket, socket.assigns.action, page_params)
  end

  defp save_page(socket, :edit, page_params) do
    case Blog.update_page(socket.assigns.page, page_params) do
      {:ok, _page} ->
        {:noreply,
         socket
         |> put_flash(:info, "Page updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_page(socket, :new, page_params) do
    case Blog.create_page(page_params) do
      {:ok, _page} ->
        {:noreply,
         socket
         |> put_flash(:info, "Page created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
