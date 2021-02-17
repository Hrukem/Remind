defmodule Remind.SendRemind.SendingRemind do
  use RemindWeb, :controller
  require Logger

  def start() do
    children = [
        %{
        id: SendingRemind,
        start: {Remind.SendRemind.SendingRemind, :sending_remind, []}
        }
      ]
    Supervisor.start_link(children, strategy: :one_for_one, name: SendingRemind)
  end

  def sending_remind() do
    receive do
      {login, event_describe, event_id} ->
        reminder = Remind.Rem.get_reminder!(event_id)
        {:ok, _reminder} = Remind.Rem.delete_reminder(reminder)
        :ets.delete(:storage, to_string(event_id))

        send_message(event_describe, login)
        sending_remind()

      _e ->
        Logger.error("Error in Remind.SendRemind.SendingRemind.sending_remind()")
        sending_remind()
    end
  end

  def send_message(event_describe, _login) do
    IO.puts("Remind your about envent: #{event_describe}")
  end
end
