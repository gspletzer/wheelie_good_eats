defmodule WheelieGoodEats.Truck do
  use Ecto.Schema

  alias WheelieGoodEats.Repo

  import Ecto.Query, only: [from: 2]

  schema "trucks" do
    field :applicant, :string
    field :address, :string
    field :status, :string
    field :food_items, :string
    field :schedule, :string
    timestamps()
  end

  def fetch_all_trucks() do
    Repo.all(WheelieGoodEats.Truck)
  end

  def fetch_query_trucks(filter) do
    included = "%#{filter}%"

    from(t in WheelieGoodEats.Truck,
      select: t,
      where: ilike(t.food_items, ^included)
    )
    |> Repo.all()
  end

  def fetch_random_truck() do
    Repo.all(WheelieGoodEats.Truck)
    |> Enum.random()
  end
end
