# setwd("~/Data/shinny/gitHub_GoogleBubbleChart")
library(dplyr)

shinyServer(function(input, output, session) {
  
  # Provide explicit colors for regions, so they don't get recoded when the
  # different series happen to be ordered differently from year to year.
  # http://andrewgelman.com/2014/09/11/mysterious-shiny-things/
  defaultColors <- c("#3366cc", "#dc3912", "#ff9900", "#109618", "#990099", "#0099c6", "#dd4477")
  series <- structure(
    lapply(defaultColors, function(color) { list(color=color) }),
    names = levels(data$Region)
    # I'd really like to work out how to make this an input into the display, as in choose a region and have the graph be impacted. 
  )
  # region selector
  output$choose_region <- renderUI(
    selectInput("data", "Region", choices = data.Regions, selected = NULL, multiple = TRUE)
    )
  # like this idea but not sure how to use it - basically if nothing selected, as is the begining state then use all fields for chart
  if (is.null("choose_region"))
    return(data.Regions)
  
  yearData <- reactive({
    # Filter to the desired year, and put the columns
    # in the order that Google's Bubble Chart expects
    # them (name, x, y, color, size). Also sort by region
    # so that Google Charts orders and colors the regions
    # consistently.
    # HOVERCARD is defined by the 1st 4 options in the list
    df <- data %>%
      filter(Year == input$year) %>%
      select(Country, Percent.ExpChange, Unit.ExpChange, 
             Region, Population,  Health.Expenditure, Life.Expectancy  ) %>%
      arrange(Region)
  })
  
  output$chart <- reactive({
    # Return the data and options
    list(
      data = googleDataTable(yearData()),
      options = list(
        title = sprintf(
          "TITLE OF PLAYGROUND GRAPH",
          input$year),
        series = series
# stuff from UI
# fluidRow(
#   shiny::column(4, offset = 4,
#                 sliderInput("year", "Year",
#                             min = min(data$Year), max = max(data$Year),
#                             value = min(data$Year), animate = TRUE)
      )
    )
  })
})