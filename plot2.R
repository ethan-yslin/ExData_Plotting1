# This is to generate plot2.png.

# Load libraries.
library(data.table)
library(dplyr)
library(lubridate)

# Read and prepare data.
dt_raw <- fread("unzip -p exdata_data_household_power_consumption.zip")
dt <- dt_raw %>% 
  filter(Date %in% c("1/2/2007","2/2/2007")) %>%
  mutate(Date_Time = dmy_hms(paste(Date, Time)))
dt[,(3:8) := lapply(.SD, as.numeric), .SDcols = 3:8] # convert cols to numeric

# Plot.
png("plot2.png", width = 480, height = 480)
with(dt, plot(Date_Time, Global_active_power, 
              type = "l", 
              xlab = "", 
              ylab = "Global Active Power (kilowatts)"))
dev.off()