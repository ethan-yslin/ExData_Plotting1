# This is to generate plot3.png.

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
png("plot3.png", width = 480, height = 480)
with(dt, plot(Date_Time, Sub_metering_1, col = "black", 
              type = "l", xlab = "", ylab = "Energy sub metering" ))
with(dt, lines(Date_Time, Sub_metering_2, col = "red"))
with(dt, lines(Date_Time, Sub_metering_3, col = "blue"))
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty = 1)
dev.off()