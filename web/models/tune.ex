defmodule Fakebook.Tune do
  use Fakebook.Web, :model

  schema "tunes" do
    field :name, :string
    field :description, :string
    field :music_xml, :string

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w(description music_xml)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
