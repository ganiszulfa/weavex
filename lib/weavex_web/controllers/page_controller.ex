defmodule WeavexWeb.PageController do
  use WeavexWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
