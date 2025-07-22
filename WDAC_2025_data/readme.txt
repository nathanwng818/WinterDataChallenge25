Winter Data Analysis Challenge 2025
Sydney Precision Data Science Centre

### Dataset description

## Information about train station locations and routes:

# Train station entrance locations
Folder name: TrainStationEntranceLocations
Data link: https://opendata.transport.nsw.gov.au/data/dataset/train-station-entrance-locations

# Sydney train routes
Folder name: SydneyTrainRoutes
Data link: https://opendata.transport.nsw.gov.au/data/dataset/sydney-train-routes

## Data on public transport use:

# Train station entries and exits, per month for all stations (Aug 2024 - May 2025)
Folder name: TrainStationEntriesExits
Data link: https://opendata.transport.nsw.gov.au/data/dataset/train-station-entries-and-exits-data

# Opal patronage, per day for major locations (Jan 2020 - July 2025)
Folder name: OpalPatronage
Data link: https://opendata.transport.nsw.gov.au/data/dataset/opal-patronage
Files were downloaded using the following script:
wget --user-agent="user" \
     --referer="https://opendata.transport.nsw.gov.au/" \
     -i opal_patronage_filelist.txt

# Example data wrangling and plotting
R script: visualise_trains.R
Compiled html: visualise_trains.html