defmodule WheelieGoodEats.Record do
  @moduledoc """
  Handles data parsing and transformation for approved trucks and updating
  the database accordingly.
  """

  alias WheelieGoodEats.Truck

  @doc """
  Filters list of approved trucks returned from SF gov to ensure only
  trucks that are not already in the database will be inserted.
  """
  @spec record_approved_trucks([integer()], [map()]) :: :ok
  def record_approved_trucks(existing_ids, approved_trucks) do
    remove_existing_trucks(approved_trucks, existing_ids)
    |> Enum.each(fn truck -> Truck.add_new_truck(truck) end)
  end

  @doc """
  Finds ids for trucks that are no longer on the "approved" list for SF gov
  and removes them from the database.
  """
  @spec remove_invalid_trucks([integer()], [map()]) :: :ok
  def remove_invalid_trucks(existing_ids, approved_trucks) do
    active_ids = get_approved_ids(approved_trucks)

    find_invalid_ids(existing_ids, active_ids)
    |> Enum.each(fn truck_id -> Truck.remove_invalid_truck(truck_id) end)
  end

  defp remove_existing_trucks(trucks, existing_ids) do
    Enum.reject(trucks, fn truck -> String.to_integer(truck["objectid"]) in existing_ids end)
  end

  defp get_approved_ids(trucks) do
    Enum.map(trucks, fn truck -> String.to_integer(truck["objectid"]) end)
  end

  defp find_invalid_ids(existing_ids, valid_ids) do
    Enum.reject(existing_ids, fn record_id -> record_id in valid_ids end)
  end
end
