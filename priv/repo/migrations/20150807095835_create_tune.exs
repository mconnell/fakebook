defmodule Fakebook.Repo.Migrations.CreateTune do
  use Ecto.Migration

  def change do
    create table(:tunes) do
      add :name, :string

      timestamps
    end

  end
end
