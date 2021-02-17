defmodule Remind.DiffTimeRemind do
  
  def compare_dates(%{"date" => date, "date_local_now" => date_local_now}) do
    date_event_NaiveDateTime = date_event_NDT(date)
    date_local_now_NaiveDateTime = date_local_now_NDT(date_local_now)

    diff_date = 
      NaiveDateTime.diff(
        date_event_NaiveDateTime, 
        date_local_now_NaiveDateTime,
        :millisecond
      )
    diff_date
  end

  defp date_event_NDT(%{
    "day" => day,
    "hour" => hour,
    "minute" => minute,
    "month" => month,
    "year" => year
  }) do

    concatenation(year, month, day, hour, minute)
  end

  defp date_local_now_NDT(date_local_now) do
    [year, month, day, hour, minute, _second] = String.split(date_local_now, ",")
    concatenation(year, month, day, hour, minute)
  end

  defp concatenation(year, month, day, hour, minute) do
    month = cheking_zero(month)
    day = cheking_zero(day)
    hour = cheking_zero(hour)
    minute = cheking_zero(minute)

    NaiveDateTime.from_iso8601!(
      year <> "-" <> month <> "-" <> day <> " " <>
        hour <> ":" <> minute <> ":" <> "00"
     )
  end

  defp cheking_zero(value)do
    value = String.to_integer(value)
    value =
      if value < 10 do
        "0" <> to_string(value)
      else to_string(value)
      end

    value
  end
end
