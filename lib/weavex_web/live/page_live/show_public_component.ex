defmodule WeavexWeb.PageLive.ShowPublicComponent do
  use WeavexWeb, :live_component

  def render(assigns) do
    ~L"""
    <div id={"page-#{@page.id}"} class="page">
      <h2 class="title"><%= @page.title %></h2>
      <div title="content"><%= @page.content %></div>
    </div>
    """
  end
end
