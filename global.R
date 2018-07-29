# July 23rd created GitHub repository
# also published to markloessi.shinyapps.io @ https://markloessi.shinyapps.io/gitHub_GoogleBubbleChart/

# data <- readRDS("~/Data/shinny/googlebubble71820/healthexp.Rds")
# data <- readRDS("/Users/markloessi/Data/shinny/googlebubble71820/healthexp.Rds")
# data <- readRDS("healthexpcsv.Rds")
# data <- readRDS("healthexp.Rds")
# need rio for convert function
library(rio)
convert("healthexpxlsx.xlsx", "healthexpxlsx.Rds")

data <- readRDS("healthexpxlsx.Rds")
# head(data)
# data$Region <- factor(data$Region) # less specific
data$Region <- as.factor(data$Region)
# data for region selector
data.Regions <- as.list(unique(data$Region))

# if you edit the XLXS then use this to convert file to RDS
# convert("healthexpxlsx.xlsx", "healthexpxlsx.Rds")

# pull data in from XLSX and convert to RDS
# library(rio) # need rio for import of rds and csv
# convert("healthexp.Rds", "healthexpxlxs.xlsx") # one fell swoop convert to XLXS
# convert("healthexpxlsx.xlsx", "healthexpxlsx.Rds") # in dir change file type

# other junk
# y4 <- import("healthexpcsv4.xlsx") # pull in file
# export(y4, "healthexpxlsx4.Rds") # kick out as RDS
# or multi step process
# y <- import("healthexp.Rds")
# y[,1] = NULL; to remove the 1st column
# export(y, "healthexpcsv.Rds") # name whatever you want

# data <- read.csv("healthexpCSV.csv") # didn't work ??
