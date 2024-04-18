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
  Filters for a list of food trucks that match food_type filter
  provided by client from the list of approved trucks already mounted
  on socket.
  """
  @spec show_query(List.t(), String.t()) :: [Truck.t()]
  def show_query(trucks, filter) do
    Enum.filter(trucks, fn truck -> String.contains?(truck.food_items, filter) end)
  end

  @doc """
  Selects a random food truck for the client from the list of approved
  trucks already mounted on socket.
  """
  @spec show_random(List.t()) :: Truck.t()
  def show_random(trucks) do
    Enum.random(trucks)
  end
end
