read_data <- function(x){
  library(lubridate)
  ######
  # Read the data
  ######
  # Only data from 2007-02-01 and 2007-02-02 will be used. It's easier to load a subset
  # Code below adapted from the half-answer found at: http://stackoverflow.com/questions/25932628/how-to-read-a-subset-of-large-dataset-in-r
  #
  # The idea is to use grep and readLines to find lines that contain the above dates.
  # We can then use skip and nrows arguments to grab only the data we want.
  
  # First we want to grab the column names to use for names later
  head <- read.table(x,nrows=1,sep=";")
  # Then we use grep to find lines of the dates we want
  grepped_data <- grep("^[1-2]/2/2007", readLines(x))
  # Then we use a skip value of the first value of grepped_data and a nrows value of the (length of grepped_data - 1).
  # NOTE: -1 of the length is used because of the header
  # This ONLY works because the dates are already ordered in the dataset
  data <- read.table(x, skip=grepped_data[1],nrows=length(grepped_data)-1, na.strings="?", sep=";")
  # Finally we add the column names back to the dataframe
  names(data) <- unlist(head)

  #######
  # Use lubridate to fix Date/Time
  #######
  data$DateTime <- dmy_hms(paste(data$Date, data$Time, sep=" "))
return(data) 
}
