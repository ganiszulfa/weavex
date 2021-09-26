defmodule Weavex.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :content, :string
    field :is_published, :boolean, default: false
    field :published_at, :naive_datetime
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :published_at, :is_published])
    |> validate_required([:title, :content, :published_at, :is_published])
  end
end
