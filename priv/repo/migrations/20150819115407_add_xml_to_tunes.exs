defmodule Fakebook.Repo.Migrations.AddXmlToTunes do
  use Ecto.Migration

  def change do
    alter table(:tunes) do
      add :music_xml, :text
    end
  end
end
