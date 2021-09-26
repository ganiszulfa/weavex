defmodule WeavexWeb.PostLive.PostComponent do
  use WeavexWeb, :live_component

  def render(assigns) do
    ~L"""
    <div id={"post-#{@post.id}"} style="margin-bottom:24px">
      <h4><%= @post.title %></h4>
      <div><em><%= @post.published_at %></em></div>

      <div>
        <span><%= live_redirect "Show", to: Routes.post_show_path(@socket, :show, @post) %></span>
        <span><%= live_patch "Edit", to: Routes.post_index_path(@socket, :edit, @post) %></span>
        <span><%= link "Delete", to: "#", phx_click: "delete", phx_value_id: @post.id, data: [confirm: "Are you sure?"] %></span>
      </div>
    </div>
    """
  end
end
