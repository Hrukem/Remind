defmodule Remind.Rem.Reminder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "remindres" do
    field :date, :naive_datetime
    field :describe, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(reminder, attrs) do
    reminder
    |> cast(attrs, [:date, :describe, :user_id])
    |> validate_required([:date, :describe, :user_id])
  end
end
