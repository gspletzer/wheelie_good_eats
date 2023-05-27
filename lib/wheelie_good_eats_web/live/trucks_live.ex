defmodule WheelieGoodEatsWeb.TrucksLive do
  use Phoenix.LiveView
  import WheelieGoodEatsWeb.CoreComponents

  def mount(_params, _session, socket) do
    trucks = WheelieGoodEats.show_all()
    craving = WheelieGoodEats.new_craving()

    {:ok, assign(socket, :trucks, trucks) |> assign(:form, to_form(craving))}
  end

  def handle_event("query", %{"craving" => craving}, socket) do
    query_trucks = WheelieGoodEats.show_query(craving["food_type"])
    reset_craving = WheelieGoodEats.new_craving()

    {:noreply, assign(socket, :trucks, query_trucks) |> assign(:form, to_form(reset_craving))}
  end

  def handle_event("random", _unsigned_params, socket) do
    {:noreply, socket |> redirect(to: "/winner")}
  end

  def handle_event("refresh", _unsigned_params, socket) do
    all_trucks = WheelieGoodEats.show_all()
    reset_craving = WheelieGoodEats.new_craving()

    {:noreply, assign(socket, :trucks, all_trucks) |> assign(:form, to_form(reset_craving))}
  end
end
