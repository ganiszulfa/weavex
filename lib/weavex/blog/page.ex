defmodule Weavex.Blog.Page do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pages" do
    field :content, :string
    field :is_published, :boolean, default: false
    field :position, :integer
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(page, attrs) do
    page
    |> cast(attrs, [:title, :content, :is_published, :position])
    |> validate_required([:title, :content, :is_published, :position])
    |> validate_length(:title, min: 2, max: 250)
  end
end
