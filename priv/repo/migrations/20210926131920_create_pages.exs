defmodule Weavex.Repo.Migrations.CreatePages do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add :title, :string
      add :content, :text
      add :is_published, :boolean, default: false, null: false
      add :position, :integer

      timestamps()
    end
  end
end
