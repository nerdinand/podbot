defmodule Podbot.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table("links") do
      add :username, :string, null: false
      add :timestamp, :timestamp, null: false
      add :link, :text, null: false

      timestamps()
    end
  end
end
