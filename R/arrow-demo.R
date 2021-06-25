library(arrow)
library(dplyr)

# Open connection to folder containing all .csv files----
ds <- open_dataset("input/", format = "csv")

# Create partitioned version of the dataset -------------------------------

ds %>%
  select(-id) %>%
  group_by(country, year) %>%
  write_dataset(path = "output/", format = "feather")


# Read data subset ------------------------------------------------------
# Open connection to partitioned dataset
ds <- open_dataset("output/", format = "feather")
# Read data: The filtering is done out of memory. This does not load the full
# dataset
df <- ds %>%
  filter(country == "COL") %>%
  collect()
