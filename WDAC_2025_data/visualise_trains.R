library(tidyverse)
library(ggiraph)
library(sf)

stations_to_ignore = c("Rosehill", "Camellia", "Rydalmere", "Dundas", "Telopea", "Carlingford")

# read in the entries and exits data to get the type of stations
ee = read.csv("TrainStationEntriesExits/train-station-entries-exits-data-may-2025.csv", header = TRUE)
head(ee)
# keep only shared or train
ee <- ee |>
  filter(Station_Type %in% c("train", "Metro Shared")) |>
  mutate(Train_Station = gsub(" Station", "", Station)) |>
  mutate(Train_Station = gsub(" $", "", Train_Station)) |>
  filter(!Train_Station %in% stations_to_ignore) |>
  mutate(TripNumber = as.numeric(ifelse(Trip == "Less than 50", 50, Trip)))
  
stations = read.csv("TrainStationEntranceLocations/stationentrances2020_v4.csv", header = TRUE)
head(stations)

stations <- stations |>
  filter(!duplicated(Train_Station)) |>
  filter(Train_Station %in% ee$Train_Station)
rownames(stations) <- stations$Train_Station

ee <- ee |>
  mutate(LAT = stations[Train_Station, "LAT"]) |>
  mutate(LONG = stations[Train_Station, "LONG"])

# get map information for Sydney
australia <- rnaturalearth::ne_states(country = "Australia", returnclass = "sf")
sydney_region <- australia[australia$name_en == "New South Wales", ]

trains = st_read("SydneyTrainRoutes/sydneytrains/SydneyTrains.shp")
trains_ll = st_transform(trains, crs = 4326)

g = ggplot(sydney_region) +
  geom_sf() +
  geom_sf(data = trains_ll, color = "red") +
  coord_sf(xlim = c(150.5, 151.3), ylim = c(-34.1, -33.4)) +
  geom_point_interactive(aes(x = LONG, y = LAT,
                             tooltip = Train_Station,
                             colour = log10(TripNumber)
                             ), 
                         data = subset(ee, MonthYear == "May-25" & Entry_Exit == "Entry")) +
  theme_minimal() +
  theme(legend.position = "bottom") + 
  scale_colour_viridis_c() +
  NULL

girafe(ggobj = g)
