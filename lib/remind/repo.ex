defmodule Remind.Repo do
  use Ecto.Repo,
    otp_app: :remind,
    adapter: Ecto.Adapters.Postgres
end
