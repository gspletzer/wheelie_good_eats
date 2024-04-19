defmodule WheelieGoodEats.RecordTest do
  use ExUnit.Case

  import WheelieGoodEats.Factory

  alias WheelieGoodEats.Record
  alias WheelieGoodEats.Truck

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(WheelieGoodEats.Repo)

    insert!(:truck, location_id: 1)
    insert!(:truck, location_id: 2)
    truck = insert!(:truck, location_id: 3)

    ids = Truck.fetch_current_ids()

    truck_1 = %{
      "objectid" => "3",
      "applicant" => truck.applicant,
      "address" => truck.address,
      "fooditems" => truck.food_items,
      "status" => truck.status,
      "schedule" => truck.schedule
    }

    truck_2 = %{
      "objectid" => "4",
      "applicant" => "truck_applicant",
      "address" => "truck_address",
      "fooditems" => "truck_food_items",
      "status" => "APPROVED",
      "schedule" => "truck_schedule"
    }

    %{
      truck_ids: ids,
      truck_1: truck_1,
      truck_2: truck_2
    }
  end

  describe "record_approved_trucks/2" do
    test "should add one new approved truck to database", %{
      truck_ids: ids,
      truck_1: truck_1,
      truck_2: truck_2
    } do
      assert length(ids) == 3

      Record.record_approved_trucks(ids, [truck_1, truck_2])

      updated_ids = Truck.fetch_current_ids()
      assert length(updated_ids) == 4
    end
  end

  describe "remove_invalid_trucks/2" do
    test "should remove trucks from database that are no longer on approved data list", %{
      truck_ids: ids,
      truck_1: truck_1,
      truck_2: truck_2
    } do
      assert length(ids) == 3
      insert!(:truck, location_id: 4)

      Record.remove_invalid_trucks(ids, [truck_1, truck_2])

      updated_ids = Truck.fetch_current_ids()
      assert length(updated_ids) == 2
    end
  end
end
