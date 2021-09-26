defmodule Weavex.BlogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Weavex.Blog` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        content: "some content",
        is_published: true,
        published_at: ~N[2021-09-25 06:02:00],
        title: "some title"
      })
      |> Weavex.Blog.create_post()

    post
  end

  @doc """
  Generate a page.
  """
  def page_fixture(attrs \\ %{}) do
    {:ok, page} =
      attrs
      |> Enum.into(%{
        content: "some content",
        is_published: true,
        position: 42,
        title: "some title"
      })
      |> Weavex.Blog.create_page()

    page
  end
end
