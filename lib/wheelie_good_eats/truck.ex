defmodule WheelieGoodEats.Truck do
  use Ecto.Schema

  alias WheelieGoodEats.Repo

  import Ecto.Query, only: [from: 2]

  schema "trucks" do
    field(:applicant, :string)
    field(:address, :string)
    field(:status, :string)
    field(:food_items, :string)
    field(:schedule, :string)
    timestamps()
  end

  @doc """
  Fetches all trucks from the database.

  The database is seeded using a csv file found in the assests folder.
  Only trucks/carts with approved permits were added to the database.
  In a future iteration the database would ideally contain all trucks and
  be routinely updated to reflect current status on:
  https://data.sfgov.org/Economy-and-Community/Mobile-Food-Facility-Permit/rqzj-sfat/data
  and a query would be added to return only trucks with approved status.
  """
  @spec fetch_all_trucks :: [Ecto.Schema.t()]
  def fetch_all_trucks() do
    Repo.all(WheelieGoodEats.Truck)
  end

  @doc """
  Fetches trucks based on a user query for food type.

  In a future iteration if all trucks were in the database, would need to add a filter
  to the query to return only trucks with approved status.
  """
  @spec fetch_query_trucks(String.t()) :: [Ecto.Schema.t()]
  def fetch_query_trucks(filter) do
    included = "%#{filter}%"

    from(t in WheelieGoodEats.Truck,
      select: t,
      where: ilike(t.food_items, ^included)
    )
    |> Repo.all()
  end

  @doc """
  Queries for all tracks and returns a randomly selected truck.

  In a future iteration if all trucks were in the database, would need to add a filter
  to return only trucks with approved status. Additionally the approach may require a
  refactor to optimize performance if the number of trucks in the database increased
  significantly.
  """
  @spec fetch_random_truck :: Ecto.Schema.t()
  def fetch_random_truck() do
    fetch_all_trucks()
    |> Enum.random()
  end
end
