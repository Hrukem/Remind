defmodule Remind do
  @moduledoc """
  Remind keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias Remind.Rem
  
  @valid_attrs %{"date" => ~N[2010-04-17 14:00:00], "describe" => "some describe"}


  def reminder_fixture(attrs \\ %{}) do

#      {:ok, reminder} =
#        attrs
#        |> Enum.into(@valid_attrs)
#        |> Rem.create_reminder()

      attrs = Enum.into(attrs, @valid_attrs)
      IO.inspect(attrs, label: "attrs")

      {:ok, reminder} = Rem.create_reminder(1, attrs)
      IO.inspect(reminder)
      reminder
      
    end

end
