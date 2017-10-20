library(tidyverse)
library(tibble)

# Read in filter Transmisions from Excel files

dataset_files <- dir("data-raw/", pattern = ".xlsx")
dataset_file_paths <- dir("data-raw/", pattern = ".xlsx", full.names = TRUE)
dataset_names <- gsub(pattern = ".xlsx", replacement = "", x = dataset_files)


filters<- tibble::tibble()
for(i in 1:length(dataset_files)){
  data <- readxl::read_xlsx(path = dataset_file_paths[i])[,3:4]

  # Compensate for Thorlabs inconsistant naming
  if(names(data)[2] == "%Transmission") names(data)[2] <- "% Transmission"
  if(names(data)[2] == "Transmission (%)") names(data)[2] <- "% Transmission"

  data <- data %>% tibble::add_column(filter = rep(dataset_names[i], length(data[[1]])))
  filters <- rbind(filters, data)
}

APD120A2_data <- read.csv("data-raw/APD120A2_data.csv", sep = ";")

devtools::use_data(filters, APD120A2_data, internal = TRUE, overwrite = TRUE)
