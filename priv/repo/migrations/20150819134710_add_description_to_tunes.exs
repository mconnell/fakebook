defmodule Fakebook.Repo.Migrations.AddDescriptionToTunes do
  use Ecto.Migration

  def change do
    alter table(:tunes) do
      add :description, :text
    end
  end
end
