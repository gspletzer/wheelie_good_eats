# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
alias WheelieGoodEats.Repo
alias WheelieGoodEats.Truck

# This is included in the event a hard reset is required for seeding the database
Repo.delete_all(Truck)

# This parses the csv file and only adds approved trucks/carts to the database
File.stream!("./assets/mobile_food_facility_permits.csv")
|> Stream.map(&String.split(&1, "\n"))
|> Stream.map(
  &(List.first(&1)
    |> String.replace(", LLC", ".LLC")
    |> String.replace(", Inc", ".Inc"))
)
|> Stream.map(&String.split(&1, ","))
|> Stream.filter(fn truck -> Enum.at(truck, 10) == "APPROVED" end)
|> Enum.each(fn truck ->
  Repo.insert!(%WheelieGoodEats.Truck{
    applicant:
      Enum.at(truck, 1)
      |> String.replace(".LLC", ", LLC")
      |> String.replace(".Inc", ", Inc")
      |> String.replace("\"", ""),
    address: Enum.at(truck, 5),
    status: Enum.at(truck, 10),
    food_items: Enum.at(truck, 11) |> String.replace(":", ","),
    schedule: Enum.at(truck, 16)
  })
end)
