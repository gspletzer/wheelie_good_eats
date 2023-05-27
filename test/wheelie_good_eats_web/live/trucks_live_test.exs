defmodule WheelieGoodEatsWeb.TrucksLiveTest do
  use WheelieGoodEatsWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "Pick for me" do
    test "redirects to /winner view", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      render_click(view, "random")
      assert_redirected(view, "/winner")
    end
  end

  describe "Narrow it down" do
    test "renders input with placeholder on mount", %{conn: conn} do
      {:ok, _page_path, html} = live(conn, "/")

      assert html =~ "What are you craving?"
    end

    test "submits a query parameter on click", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      assert render_submit(view, "query", %{craving: %{food_type: "pho"}}) =~ "Uh-oh, no matches."
    end
  end
end
