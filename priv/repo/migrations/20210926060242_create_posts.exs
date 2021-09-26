defmodule Weavex.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :content, :text
      add :published_at, :naive_datetime
      add :is_published, :boolean, default: false, null: false

      timestamps()
    end
  end
end
