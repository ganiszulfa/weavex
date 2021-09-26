defmodule Weavex.BlogTest do
  use Weavex.DataCase

  alias Weavex.Blog

  describe "posts" do
    alias Weavex.Blog.Post

    import Weavex.BlogFixtures

    @invalid_attrs %{content: nil, is_published: nil, published_at: nil, title: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Blog.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Blog.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{content: "some content", is_published: true, published_at: ~N[2021-09-25 06:02:00], title: "some title"}

      assert {:ok, %Post{} = post} = Blog.create_post(valid_attrs)
      assert post.content == "some content"
      assert post.is_published == true
      assert post.published_at == ~N[2021-09-25 06:02:00]
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{content: "some updated content", is_published: false, published_at: ~N[2021-09-26 06:02:00], title: "some updated title"}

      assert {:ok, %Post{} = post} = Blog.update_post(post, update_attrs)
      assert post.content == "some updated content"
      assert post.is_published == false
      assert post.published_at == ~N[2021-09-26 06:02:00]
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_post(post, @invalid_attrs)
      assert post == Blog.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Blog.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Blog.change_post(post)
    end
  end

  describe "pages" do
    alias Weavex.Blog.Page

    import Weavex.BlogFixtures

    @invalid_attrs %{content: nil, is_published: nil, position: nil, title: nil}

    test "list_pages/0 returns all pages" do
      page = page_fixture()
      assert Blog.list_pages() == [page]
    end

    test "get_page!/1 returns the page with given id" do
      page = page_fixture()
      assert Blog.get_page!(page.id) == page
    end

    test "create_page/1 with valid data creates a page" do
      valid_attrs = %{content: "some content", is_published: true, position: 42, title: "some title"}

      assert {:ok, %Page{} = page} = Blog.create_page(valid_attrs)
      assert page.content == "some content"
      assert page.is_published == true
      assert page.position == 42
      assert page.title == "some title"
    end

    test "create_page/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_page(@invalid_attrs)
    end

    test "update_page/2 with valid data updates the page" do
      page = page_fixture()
      update_attrs = %{content: "some updated content", is_published: false, position: 43, title: "some updated title"}

      assert {:ok, %Page{} = page} = Blog.update_page(page, update_attrs)
      assert page.content == "some updated content"
      assert page.is_published == false
      assert page.position == 43
      assert page.title == "some updated title"
    end

    test "update_page/2 with invalid data returns error changeset" do
      page = page_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_page(page, @invalid_attrs)
      assert page == Blog.get_page!(page.id)
    end

    test "delete_page/1 deletes the page" do
      page = page_fixture()
      assert {:ok, %Page{}} = Blog.delete_page(page)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_page!(page.id) end
    end

    test "change_page/1 returns a page changeset" do
      page = page_fixture()
      assert %Ecto.Changeset{} = Blog.change_page(page)
    end
  end
end
