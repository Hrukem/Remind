defmodule Remind.Repo.Migrations.CreateRemindres do
  use Ecto.Migration

  def change do
    create table(:remindres) do
      add :date, :naive_datetime
      add :describe, :string
      add :user_id, :integer
#      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:remindres, [:user_id])
  end
end
