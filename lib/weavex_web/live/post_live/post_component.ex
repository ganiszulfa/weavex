defmodule WeavexWeb.PostLive.PostComponent do
  use WeavexWeb, :live_component

  def render(assigns) do
    ~L"""
    <div id={"post-#{@post.id}"} class="post">
      <h2 class="title">
      <%= live_redirect @post.title, to: Routes.post_show_public_path(@socket, :show_public, Slugger.slugify_downcase(String.slice(@post.title, 0..24)), @post.id) %> </h2>
      <div><em><%= @post.published_at %></em></div>
      <div class="content"><%= raw Earmark.as_html!(@post.content) %></div>

      <div>
      </div>
    </div>
    """
  end
end
