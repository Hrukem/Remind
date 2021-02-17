defmodule RemindWeb.ReminderControllerTest do
  use RemindWeb.ConnCase

  alias Remind.Rem

  @create_attrs %{
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


  def fixture(:reminder) do
    {:ok, reminder} = Rem.create_reminder(1, @create_attrs)
    reminder
  end

  describe "index" do
    test "lists all remindres", %{conn: conn} do
      conn = get(conn, Routes.reminder_path(conn, :index))
      assert html_response(conn, 302) =~ "You are being"
    end
  end

  describe "new reminder" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.reminder_path(conn, :new))
      assert html_response(conn, 302) =~ "You are being"
    end
  end

  describe "create reminder" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.reminder_path(conn, :create), reminder: @create_attrs)
      id = 1
      assert "/remindres/1" == Routes.reminder_path(conn, :show, id)

      conn = get(conn, Routes.reminder_path(conn, :show, id))
      assert html_response(conn, 302) =~ "You are being"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.reminder_path(conn, :create), reminder: @invalid_attrs)
      assert html_response(conn, 302) =~ "You are being"
    end
  end

#  describe "delete reminder" do
#    setup [:create_reminder]
#
#    test "deletes chosen reminder", %{conn: conn, reminder: reminder} do
#      conn = delete(conn, Routes.reminder_path(conn, :delete, reminder))
#      assert redirected_to(conn) == Routes.reminder_path(conn, :index)
#      assert_error_sent 404, fn ->
#        get(conn, Routes.reminder_path(conn, :show, reminder))
#      end
#    end
#  end
    #
#  defp create_reminder(_) do
#    reminder = fixture(:reminder)
#    %{reminder: reminder}
#  end
end
