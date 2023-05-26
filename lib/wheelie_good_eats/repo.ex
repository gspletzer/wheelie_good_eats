defmodule WheelieGoodEats.Repo do
  use Ecto.Repo,
    otp_app: :wheelie_good_eats,
    adapter: Ecto.Adapters.Postgres
end
