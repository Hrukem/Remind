defmodule Remind.RemTest do
  use Remind.DataCase

  alias Remind.Rem

  describe "remindres" do
#    alias Remind.Rem.Reminder

    @valid_attrs %{
        "date" => %{
          "day" => "1",
          "hour" => "0",
          "minute" => "0",
          "month" => "2",
          "year" => "2023"
        },
        "date_local_now" => "2021,2,15,7,20,45",
        "describe" => "b"
      }

    @invalid_attrs %{
        "date" => nil,
        "date_local_now" => nil,
        "describe" => nil
      }


    def reminder_fixture(attrs \\ %{}) do
      attrs = Enum.into(attrs, @valid_attrs)

      {:ok, reminder} = Rem.create_reminder(1, attrs)
      reminder
      
    end

#    test "get_reminder!/1 returns the reminder with given id" do
#      reminder = reminder_fixture()
#      assert Rem.get_reminder!(reminder.id) == reminder
#    end

#    test "create_reminder/1 with valid data creates a reminder" do
#      assert {:ok, %Reminder{} = reminder} = Rem.create_reminder(1, @valid_attrs)
#      assert reminder.date == ~N[2010-04-17 14:00:00]
#      assert reminder.describe == "some describe"
#    end

    test "create_reminder/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rem.create_reminder(1, @invalid_attrs)
    end

#    test "delete_reminder/1 deletes the reminder" do
#      reminder = reminder_fixture()
#      assert {:ok, %Reminder{}} = Rem.delete_reminder(reminder)
#      assert_raise Ecto.NoResultsError, fn -> Rem.get_reminder!(reminder.id) end
#    end

  end
end
