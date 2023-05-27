defmodule WheelieGoodEats do
  @moduledoc """
  Top-level API for the Wheelie Good Eats application.
  """

  alias WheelieGoodEats.Truck

  @doc """
  Fetches all food trucks for the client.
  """
  @spec show_all :: [Truck.t()]
  def show_all() do
    Truck.fetch_all_trucks()
  end

  @doc """
  Fetches all food trucks that match query filter
  provided by client.
  """
  @spec show_query(String.t()) :: [Truck.t()]
  def show_query(filter) do
    Truck.fetch_query_trucks(filter)
  end

  @doc """
  Fetches a random food truck for the client.
  """
  @spec show_random :: [Truck.t()]
  def show_random() do
    Truck.fetch_random_truck()
  end
end
