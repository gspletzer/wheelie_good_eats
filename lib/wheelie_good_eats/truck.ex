defmodule WheelieGoodEats.Truck do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  alias WheelieGoodEats.Truck
  alias WheelieGoodEats.Repo

  schema "trucks" do
    field(:location_id, :integer)
    field(:applicant, :string)
    field(:address, :string)
    field(:status, :string)
    field(:food_items, :string)
    field(:schedule, :string)
    timestamps()
  end

  @required ~w(location_id applicant address status food_items schedule)a

  @doc """
  Generates a valid Truck changeset for interaction with database.
  """
  def changeset(%__MODULE__{} = truck, params) do
    truck
    |> cast(params, @required)
    |> unique_constraint(:location_id, name: :trucks_location_id_index)
  end

  @doc """
  Fetches all trucks from the database.
  """
  @spec fetch_all_trucks :: [Ecto.Schema.t()]
  def fetch_all_trucks() do
    Repo.all(Truck)
  end

  @doc """
  Fetches location_id for all Trucks in the database.

  The location_id is the unique id from SF gov data, so the list of
  current location_ids in database is compared to daily list of approved
  trucks retrieved from SODA API to determine which ones need added to database
  and which ones should be remmoved from database.
  """
  @spec fetch_current_ids() :: [integer()]
  def fetch_current_ids() do
    from(t in Truck,
      select: t.location_id
    )
    |> Repo.all()
  end

  @doc """
  Inserts a new truck into the Trucks table.
  """
  @spec add_new_truck(map()) :: Ecto.Schema.t()
  def add_new_truck(truck) do
    params = %{
      "location_id" => truck["objectid"],
      "applicant" => truck["applicant"],
      "address" => truck["address"],
      "status" => truck["status"],
      "food_items" => truck["fooditems"],
      "schedule" => truck["schedule"]
    }

    changeset(%__MODULE__{}, params)
    |> Repo.insert!()
  end

  @doc """
  Removes truck with given location_id from the database.

  If features of this app expand, will move get_by key and value to be passed as
  arguments, so that it can use more than one row attribute to select the truck
  for deletion.
  """
  @spec remove_invalid_truck(integer()) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}
  def remove_invalid_truck(truck_id) do
    Repo.get_by(Truck, location_id: truck_id)
    |> Repo.delete()
  end
end
