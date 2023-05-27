defmodule WheelieGoodEats.Factory do
  @moduledoc """
  Factory for generating trucks in the database for testing.
  """
  alias WheelieGoodEats.Repo
  alias WheelieGoodEats.Truck

  # Factory

  @doc """
  This builds a truck with randomized data for applicant, address and food_items.
  """
  @spec build(:truck) :: Truck.t()
  def build(:truck) do
    %Truck{
      applicant: Faker.StarWars.planet(),
      address: Faker.Address.street_address(),
      food_items: Faker.Food.dish(),
      status: "APPROVED",
      schedule: Faker.Internet.url()
    }
  end

  # Factory API

  @doc """
  This allows tests to call to Factory to build a designated struct/schema.
  If no attributes are provided, Faker will be used to generate
  """
  def build(factory_name, attributes) do
    factory_name |> build() |> struct!(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    factory_name |> build(attributes) |> Repo.insert!()
  end
end
