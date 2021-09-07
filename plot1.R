# This is to generate plot1.png.

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
png("plot1.png", width = 480, height = 480)
hist(dt$Global_active_power, 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power", 
     col = "red")
dev.off()