defmodule WeavexWeb.PageLive.ShowPublic do
  use WeavexWeb, :live_view

  alias Weavex.Blog

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Blog.subscribe_to_page()

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"slug" => _, "id" => id}, _, socket) do
    page = Blog.get_page!(id)

    {:noreply,
     socket
     |> assign(:page_title, page.title)
     |> assign(:page, page)}
  end
end
