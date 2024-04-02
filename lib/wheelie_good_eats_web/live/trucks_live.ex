defmodule WheelieGoodEatsWeb.TrucksLive do
  use Phoenix.LiveView
  import WheelieGoodEatsWeb.CoreComponents

  def mount(_params, _session, socket) do
    trucks = WheelieGoodEats.show_all()
    craving = WheelieGoodEats.new_craving()
    selected_truck = ""

    {:ok,
     assign(socket, :trucks, trucks)
     |> assign(:form, to_form(craving))
     |> assign(:selected, selected_truck)}
  end

  def handle_event("query", %{"craving" => craving}, socket) do
    if craving["food_type"] != "" do
      reset_selected = ""
      query_trucks = WheelieGoodEats.show_query(craving["food_type"])
      reset_craving = WheelieGoodEats.new_craving()

      {:noreply,
       assign(socket, :trucks, query_trucks)
       |> assign(:form, to_form(reset_craving))
       |> assign(:selected, reset_selected)}
    else
      {:noreply, put_flash(socket, :error, "Cannot be empty.")}
    end
  end

  def handle_event("random", _unsigned_params, socket) do
    selected_truck = WheelieGoodEats.show_random()

    {:noreply, assign(socket, :selected, selected_truck)}
    # {:noreply, socket |> redirect(to: "/winner")}
  end

  def handle_event("refresh", _unsigned_params, socket) do
    all_trucks = WheelieGoodEats.show_all()
    reset_craving = WheelieGoodEats.new_craving()
    reset_selected = ""

    {:noreply,
     assign(socket, :trucks, all_trucks)
     |> assign(:form, to_form(reset_craving))
     |> assign(:selected, reset_selected)}
  end
end
