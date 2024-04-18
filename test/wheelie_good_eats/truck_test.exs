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
end
