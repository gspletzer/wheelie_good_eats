defmodule WheelieGoodEats do
  @moduledoc """
  Top-level API for the Wheelie Good Eats application.
  """
  alias WheelieGoodEats.Craving
  alias WheelieGoodEats.Truck

  @type craving :: Craving.changeset()

  @doc """
  Generate a new craving changeset for the client input form.
  """
  @spec new_craving :: craving()
  def new_craving() do
    Craving.new() |> Craving.changeset()
  end

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
  @spec show_random :: Truck.t()
  def show_random() do
    Truck.fetch_random_truck()
  end
end
