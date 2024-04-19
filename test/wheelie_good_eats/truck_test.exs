defmodule WheelieGoodEats.TruckTest do
  use ExUnit.Case

  import WheelieGoodEats.Factory

  alias WheelieGoodEats.Truck

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(WheelieGoodEats.Repo)

    %{
      trucks: [
        insert!(:truck, location_id: 1),
        insert!(:truck, location_id: 2),
        insert!(:truck, location_id: 3, food_items: "tacos")
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

  describe "fetch_current_ids/0" do
    test "should return a list of integers", %{trucks: trucks} do
      result = Truck.fetch_current_ids()

      assert is_integer(List.first(result))

      for truck <- trucks do
        assert truck.location_id in result
      end
    end
  end

  describe "add_new_truck/1" do
    test "should insert a new truck into database" do
      truck = %{
        "objectid" => "4",
        "applicant" => "truck_applicant",
        "address" => "truck_address",
        "fooditems" => "truck_food_items",
        "status" => "APPROVED",
        "schedule" => "truck_schedule"
      }

      Truck.add_new_truck(truck)

      result = Truck.fetch_current_ids()

      assert 4 in result
      assert length(result) == 4
    end
  end

  describe "remove_invalid_truck/1" do
    test "should remove the truck with given location_id from database" do
      Truck.remove_invalid_truck(1)

      result = Truck.fetch_current_ids()

      assert 1 not in result
      assert length(result) == 2
    end
  end
end
