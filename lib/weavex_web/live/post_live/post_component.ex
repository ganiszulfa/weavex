defmodule WeavexWeb.PostLive.PostComponent do
  use WeavexWeb, :live_component

  def render(assigns) do
    ~L"""
    <div class="columns">
      <div class="column is-10 is-offset-1">
        <div id={"post-#{@post.id}"} class="post">
          <h2 class="title">
          <%= @post.title %>
          </h2>
          <%= if @post.published_at do %>
            <div class="date mb-3">
              <span class="icon-text has-text-grey">
                <span class="icon">
                  <i class="fas fa-calendar"></i>
                </span>
                <span>
                  <%= Calendar.strftime(@post.published_at, "%A, %d %B %Y") %>
                </span>
              </span>
            </div>
          <% end %>
          <div class="content"><%= raw Earmark.as_html!(@post.content) %></div>
          <div>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
