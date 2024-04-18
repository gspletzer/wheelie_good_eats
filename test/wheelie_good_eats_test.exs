defmodule WheelieGoodEatsTest do
  use ExUnit.Case

  import WheelieGoodEats.Factory

  import WheelieGoodEats

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(WheelieGoodEats.Repo)

    insert!(:truck)
    insert!(:truck)
    insert!(:truck, food_items: "tacos")

    :ok
  end

  describe "new_craving/0" do
    test "should return a changeset with key of food_type and value of nil" do
      result = new_craving()
      assert Map.has_key?(result.data, :food_type)
      assert result.data.food_type == nil
    end
  end

  describe "show_query/2" do
    setup do
      %{trucks: show_all()}
    end

    test "should return list of trucks that matches food_type filter", %{trucks: trucks} do
      input = "tacos"
      result = show_query(trucks, input) |> List.first()
      assert String.contains?(result.food_items, input)
    end

    test "should return an empty list if no trucks match food_type filter", %{trucks: trucks} do
      input = "pho"
      result = show_query(trucks, input)
      assert is_list(result)
      assert Enum.empty?(result)
    end
  end

  describe "show_random/1" do
    test "should return a truck from the list of trucks" do
      trucks = show_all()

      result = show_random(trucks)
      assert is_struct(result, WheelieGoodEats.Truck)
    end
  end
end
