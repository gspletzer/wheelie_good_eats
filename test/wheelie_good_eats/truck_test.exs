defmodule WheelieGoodEats.TruckTest do
  use ExUnit.Case

  import WheelieGoodEats.Factory

  alias WheelieGoodEats.Truck

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(WheelieGoodEats.Repo)

    %{
      trucks: [
        insert!(:truck),
        insert!(:truck),
        insert!(:truck, food_items: "tacos")
      ]
    }
  end

  describe "fetch_all_trucks/0" do
    test "should return all trucks in database", %{trucks: trucks} do
      result = Truck.fetch_all_trucks()
      assert 3 == length(result)

      assert Enum.sort(result) == Enum.sort(trucks)

      for truck <- trucks do
        assert truck in result
      end
    end
  end

  describe "fetch_query_trucks/1" do
    test "should return only truck(s) that contain input in food_items" do
      input = "tacos"
      result = Truck.fetch_query_trucks(input) |> List.first()
      assert String.contains?(result.food_items, input)
    end
  end

  describe "fetch_random_truck/0" do
    test "should return only one truck" do
      result = Truck.fetch_random_truck()
      assert is_struct(result, Truck)
    end
  end
end
