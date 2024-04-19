defmodule WheelieGoodEats.RecordWorker do
  @moduledoc """
  Oban worker that facilitates daily run to update the trucks table.

  It is scheduled to run at 11p PT (cron plugin is configured in "Etc/UTC"),
  but can also be run ad-hoc with the following command in the terminal:

  `WheelieGoodEats.RecordWorker.perform(%{})`
  """
  use Oban.Worker, queue: :cron, max_attempts: 2

  require Logger

  @impl Oban.Worker
  def perform(_args) do
    Logger.info("Starting sync of approved trucks")

    WheelieGoodEats.update_approved_trucks()

    Logger.info("Truck update complete.")
  end
end
