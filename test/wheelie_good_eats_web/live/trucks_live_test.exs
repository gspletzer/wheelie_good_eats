defmodule WheelieGoodEatsWeb.TrucksLiveTest do
  use WheelieGoodEatsWeb.ConnCase

  import Phoenix.LiveViewTest
  alias WheelieGoodEats.Factory

  setup do
    truck_one = Factory.insert!(:truck, location_id: 1)
    truck_two = Factory.insert!(:truck, location_id: 2)
    truck_three = Factory.insert!(:truck, location_id: 3, food_items: "tacos")

    [truck_one: truck_one, truck_two: truck_two, truck_three: truck_three]
  end

  describe "Pick for me" do
    test "renders a random truck", %{
      conn: conn,
      truck_one: truck_one,
      truck_two: truck_two,
      truck_three: truck_three
    } do
      {:ok, view, html} = live(conn, "/")

      assert html =~ truck_one.applicant
      assert html =~ truck_two.applicant
      assert html =~ truck_three.applicant

      assert view
             |> element("button", "PICK FOR ME")
             |> render_click() =~ "Enjoy dining at:"
    end
  end

  describe "Search" do
    test "renders input with placeholder on mount", %{conn: conn} do
      {:ok, _page_path, html} = live(conn, "/")

      assert html =~ "What are you craving?"
    end

    test "renders truck with matching menu item on submit", %{
      conn: conn,
      truck_one: truck_one,
      truck_two: truck_two,
      truck_three: truck_three
    } do
      {:ok, view, html} = live(conn, "/")

      assert html =~ truck_one.applicant
      assert html =~ truck_two.applicant
      assert html =~ truck_three.applicant

      assert render_submit(view, "query", %{craving: %{food_type: "tacos"}}) =~
               truck_three.applicant
    end

    test "renders a message when no trucks match query on submit", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      assert render_submit(view, "query", %{craving: %{food_type: "pho"}}) =~ "Uh-oh, no matches."
    end
  end
end
