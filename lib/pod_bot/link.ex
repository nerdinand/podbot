defmodule PodBot.Link do
  use Ecto.Schema

  schema "links" do
    field(:username, :string)
    field(:timestamp, :utc_datetime)
    field(:link, :string)

    timestamps
  end
end
