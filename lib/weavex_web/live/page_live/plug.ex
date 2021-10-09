defmodule WeavexWeb.PageLive.Plug do
  import Plug.Conn
  alias Weavex.Blog

  def fetch_pages(conn, _opts) do
    pages = Blog.list_pages()
    assign(conn, :pages, pages)
  end
end
