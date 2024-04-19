defmodule WheelieGoodEats.SodaApi do
  @moduledoc """
  API module for Socrata Open Data API.
  """
  use Tesla

  require Logger

  @url "https://data.sfgov.org/resource/rqzj-sfat.json"

  plug(Tesla.Middleware.Headers, [
    {"X-App-Token", Application.get_env(:wheelie_good_eats, __MODULE__)[:api_key]}
  ])

  @doc """
  Fetches list of trucks on SF gov's Mobile Food Facility Permit data table
  and filters result to return only trucks with an approved status.
  """
  def fetch_approved_trucks() do
    {:ok, %{status: status, body: body}} = get(@url)

    if status == 200 do
      Jason.decode!(body)
      |> Enum.filter(fn truck -> truck["status"] == "APPROVED" end)
    else
      Logger.error("Unable to fetch trucks from SF gov")
      {:error, "Unable to fetch trucks"}
    end
  end
end
