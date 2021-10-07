defmodule WeavexWeb.PageLive.ShowPublicComponent do
  use WeavexWeb, :live_component

  def render(assigns) do
    ~L"""
    <div class="columns">
      <div class="column is-10 is-offset-1">
        <div id={"page-#{@page.id}"} class="page">
          <h2 class="title"><%= @page.title %></h2>
          <div title="content"><%= @page.content %></div>
        </div>
      </div>
    </div>
    """
  end
end
