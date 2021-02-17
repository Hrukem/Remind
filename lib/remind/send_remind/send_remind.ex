defmodule Remind.SendRemind.SendRemind do
  def start(time, login, event_describe, event_id) do
    ref_timer = 
      Process.send_after(
        SendingRemind, 
        {login, event_describe, event_id}, 
        time
      )
    :ets.insert(:storage, {event_id, ref_timer})
  end
end
