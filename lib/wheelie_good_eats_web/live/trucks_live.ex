defmodule WheelieGoodEatsWeb.TrucksLive do
  use Phoenix.LiveView
  import WheelieGoodEatsWeb.CoreComponents

  def mount(_params, _session, socket) do
    trucks = WheelieGoodEats.show_all()
    craving = WheelieGoodEats.new_craving()

    {:ok,
     assign(socket, :trucks, trucks)
     |> assign(:form, to_form(craving))
     |> assign(:filtered_trucks, nil)
     |> assign(:random_truck, nil)}
  end

  def handle_event("query", %{"craving" => craving}, socket) do
    if craving["food_type"] != "" do
      query_trucks = WheelieGoodEats.show_query(socket.assigns.trucks, craving["food_type"])
      reset_craving = WheelieGoodEats.new_craving()

      {:noreply,
       assign(socket, :filtered_trucks, query_trucks)
       |> assign(:form, to_form(reset_craving))
       |> assign(:random_truck, nil)}
    else
      {:noreply, put_flash(socket, :error, "Cannot be empty.")}
    end
  end

  def handle_event("random", _unsigned_params, socket) do
    trucks = socket.assigns.trucks
    selected_truck = WheelieGoodEats.show_random(trucks)

    {:noreply,
     assign(socket, :random_truck, selected_truck)
     |> assign(:filtered_trucks, nil)}
  end

  def handle_event("refresh", _unsigned_params, socket) do
    reset_craving = WheelieGoodEats.new_craving()

    {:noreply,
     assign(socket, :form, to_form(reset_craving))
     |> assign(:filtered_trucks, nil)
     |> assign(:random_truck, nil)}
  end
end
