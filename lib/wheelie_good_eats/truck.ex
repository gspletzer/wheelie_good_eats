defmodule WheelieGoodEats.Truck do
  use Ecto.Schema

  alias WheelieGoodEats.Repo

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
end
