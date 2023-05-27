defmodule WheelieGoodEatsWeb.WinnerLive do
  use Phoenix.LiveView
  import WheelieGoodEatsWeb.CoreComponents

  def mount(_params, _session, socket) do
    selected_truck = WheelieGoodEats.show_random()

    {:ok, assign(socket, :trucks, selected_truck)}
  end

  def handle_event("all", _unsigned_params, socket) do
    {:noreply, socket |> redirect(to: "/")}
  end

  def handle_event("new", _unsigned_params, socket) do
    new_truck = WheelieGoodEats.show_random()

    {:noreply, assign(socket, :trucks, new_truck)}
  end
end
