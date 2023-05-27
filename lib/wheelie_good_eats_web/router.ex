defmodule WheelieGoodEatsWeb.Router do
  use WheelieGoodEatsWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, {WheelieGoodEatsWeb.Layouts, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", WheelieGoodEatsWeb do
    pipe_through(:browser)

    live("/", TrucksLive)
    live("/winner", WinnerLive)
  end
end
