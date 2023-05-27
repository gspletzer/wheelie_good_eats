defmodule WheelieGoodEats.Craving do
  defstruct [:food_type]

  @types %{food_type: :string}
  @type t :: %__MODULE__{}
  @type changeset :: Ecto.Changeset.t()

  @doc """
  Generates an empty Craving struct.
  """
  @spec new :: t()
  def new do
    %__MODULE__{}
  end

  @doc """
  Adds value provided by params to the designated key.any()

  This is necessary for working with the form on the frontend.
  It is designed to be reusable in the event a need for an updated
  changeset is required in future iterations.
  """
  @spec changeset(t(), map()) :: changeset()
  def changeset(craving, params \\ %{"food_type" => ""}) do
    Ecto.Changeset.cast({craving, @types}, params, Map.keys(@types))
  end
end
