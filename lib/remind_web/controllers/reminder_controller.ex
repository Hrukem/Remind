defmodule RemindWeb.ReminderController do
  use RemindWeb, :controller

  alias Remind.Rem
  alias Remind.Rem.Reminder

  def index(conn, _params) do
    remindres = Rem.list_remindres(conn.assigns.current_user.id)
    render(conn, "index.html", remindres: remindres)
  end

  def new(conn, _params) do
    changeset = Rem.change_reminder(%Reminder{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"reminder" => reminder_params}) do
    date = Map.get(reminder_params, "date")

    year = Map.get(date, "year") |> String.to_integer()
    month = Map.get(date, "month") |> String.to_integer()
    day = Map.get(date, "day") |> String.to_integer()

    if Calendar.ISO.valid_date?(year, month, day) do
      create_do(conn, reminder_params)
    else
      conn
      |> put_flash(:info, "Error.
       The date you entered is not correct. 
        For example, \"February, 30\" or \"June, 31\". ")
      |> redirect(to: Routes.reminder_path(conn, :new))
    end
  end

  defp create_do(conn, reminder_params) do
    if (time = Remind.DiffTimeRemind.compare_dates(reminder_params)) > 0 do
      create_do_do(conn, reminder_params, time)
    else 
      conn
      |> put_flash(:info, "Error.
        You entered a date that has already arrived.")
      |> redirect(to: Routes.reminder_path(conn, :new))
    end
  end

  defp create_do_do(conn, reminder_params, time) do
    case Rem.create_reminder(conn.assigns.current_user.id, reminder_params) do
      {:ok, reminder} ->
        Remind.SendRemind.SendRemind.start(
          time, 
          conn.assigns.current_user.email, 
          reminder.describe, 
          reminder.id
        )
        
        conn
        |> put_flash(:info, "Reminder created successfully.")
        |> redirect(to: Routes.reminder_path(conn, :show, reminder))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    reminder = Rem.get_reminder!(id)
    render(conn, "show.html", reminder: reminder)
  end

  def edit(conn, %{"id" => id}) do
    reminder = Rem.get_reminder!(id)
    changeset = Rem.change_reminder(reminder)
    render(conn, "edit.html", reminder: reminder, changeset: changeset)
  end

  def update(conn, %{"id" => id, "reminder" => reminder_params}) do
    reminder = Rem.get_reminder!(id)

    case Rem.update_reminder(reminder, reminder_params) do
      {:ok, reminder} ->
        conn
        |> put_flash(:info, "Reminder updated successfully.")
        |> redirect(to: Routes.reminder_path(conn, :show, reminder))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", reminder: reminder, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    [{_id, pid_timer}] = :ets.lookup(:storage, String.to_integer(id))
    Process.cancel_timer(pid_timer)

    reminder = Rem.get_reminder!(id)
    {:ok, _reminder} = Rem.delete_reminder(reminder)

    conn
    |> put_flash(:info, "Reminder deleted successfully.")
    |> redirect(to: Routes.reminder_path(conn, :index))
  end
end
