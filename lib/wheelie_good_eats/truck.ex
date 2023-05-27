defmodule WheelieGoodEats.Truck do
  use Ecto.Schema

  schema "trucks" do
    field :applicant, :string
    field :address, :string
    field :status, :string
    field :food_items, :string
    field :schedule, :string
    timestamps()
  end
end
