defmodule WeavexWeb.PageLiveTest do
  use WeavexWeb.ConnCase

  import Phoenix.LiveViewTest
  import Weavex.BlogFixtures

  @create_attrs %{content: "some content", is_published: true, position: 42, title: "some title"}
  @update_attrs %{content: "some updated content", is_published: false, position: 43, title: "some updated title"}
  @invalid_attrs %{content: nil, is_published: false, position: nil, title: nil}

  defp create_page(_) do
    page = page_fixture()
    %{page: page}
  end

  describe "Index" do
    setup [:create_page]

    test "lists all pages", %{conn: conn, page: page} do
      {:ok, _index_live, html} = live(conn, Routes.page_index_path(conn, :index))

      assert html =~ "Listing Pages"
      assert html =~ page.content
    end

    test "saves new page", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.page_index_path(conn, :index))

      assert index_live |> element("a", "New Page") |> render_click() =~
               "New Page"

      assert_patch(index_live, Routes.page_index_path(conn, :new))

      assert index_live
             |> form("#page-form", page: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#page-form", page: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.page_index_path(conn, :index))

      assert html =~ "Page created successfully"
      assert html =~ "some content"
    end

    test "updates page in listing", %{conn: conn, page: page} do
      {:ok, index_live, _html} = live(conn, Routes.page_index_path(conn, :index))

      assert index_live |> element("#page-#{page.id} a", "Edit") |> render_click() =~
               "Edit Page"

      assert_patch(index_live, Routes.page_index_path(conn, :edit, page))

      assert index_live
             |> form("#page-form", page: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#page-form", page: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.page_index_path(conn, :index))

      assert html =~ "Page updated successfully"
      assert html =~ "some updated content"
    end

    test "deletes page in listing", %{conn: conn, page: page} do
      {:ok, index_live, _html} = live(conn, Routes.page_index_path(conn, :index))

      assert index_live |> element("#page-#{page.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#page-#{page.id}")
    end
  end

  describe "Show" do
    setup [:create_page]

    test "displays page", %{conn: conn, page: page} do
      {:ok, _show_live, html} = live(conn, Routes.page_show_path(conn, :show, page))

      assert html =~ "Show Page"
      assert html =~ page.content
    end

    test "updates page within modal", %{conn: conn, page: page} do
      {:ok, show_live, _html} = live(conn, Routes.page_show_path(conn, :show, page))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Page"

      assert_patch(show_live, Routes.page_show_path(conn, :edit, page))

      assert show_live
             |> form("#page-form", page: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#page-form", page: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.page_show_path(conn, :show, page))

      assert html =~ "Page updated successfully"
      assert html =~ "some updated content"
    end
  end
end
