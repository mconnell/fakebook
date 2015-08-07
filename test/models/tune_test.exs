defmodule Fakebook.TuneTest do
  use Fakebook.ModelCase

  alias Fakebook.Tune

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Tune.changeset(%Tune{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Tune.changeset(%Tune{}, @invalid_attrs)
    refute changeset.valid?
  end
end
