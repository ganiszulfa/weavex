defmodule WeavexWeb.PostLive.ShowPublic do
  use WeavexWeb, :live_view

  alias Weavex.Blog

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Blog.subscribe()

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"slug" => _, "id" => id}, _, socket) do
    post = Blog.get_post!(id)

    {:noreply,
     socket
     |> assign(:page_title, post.title)
     |> assign(:post, post)}
  end
end
