defmodule WheelieGoodEats.Repo.Migrations.AddTruckLocationId do
  use Ecto.Migration

  def change do
    alter table(:trucks) do
      add :location_id, :integer
    end

    create unique_index(:trucks, [:location_id], name: :trucks_location_id_index)
  end
end
