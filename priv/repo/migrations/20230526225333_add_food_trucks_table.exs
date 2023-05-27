defmodule WheelieGoodEats.Repo.Migrations.AddFoodTrucksTable do
  use Ecto.Migration

  def change do
    create table(:trucks) do
      add :applicant, :string
      add :address, :string
      add :status, :string
      add :food_items, :string
      add :schedule, :string
      timestamps()
    end
  end
end
