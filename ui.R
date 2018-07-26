# More info:
#   https://github.com/jcheng5/googleCharts
# Install:
#   devtools::install_github("jcheng5/googleCharts")
library(googleCharts)

# Use global max/min for axes so the view window stays
# constant as the user moves between years
xlim <- list(
  min = min(data$Percent.ExpChange) - 10,   # Health.Expenditure
  max = max(data$Percent.ExpChange) + 10    # Health.Expenditure
)
ylim <- list(
  min = min(data$Unit.ExpChange),      # Life.Expectancy
  max = max(data$Unit.ExpChange) + 3  # Life.Expectancy
)

shinyUI(fluidPage(
  # This line loads the Google Charts JS library
  googleChartsInit(),
  
  # Use the Google webfont "Source Sans Pro"
  tags$link(
    href=paste0("http://fonts.googleapis.com/css?",
                "family=Source+Sans+Pro:300,600,300italic"),
    rel="stylesheet", type="text/css"),
  tags$style(type="text/css",
             "body {font-family: 'Source Sans Pro'}"
  ),
  
  h2("Google Charts demo"),
  
  googleBubbleChart("chart",
                    width="100%", height = "475px",        # height = "475px"
                    # Set the default options for this chart; they can be
                    # overridden in server.R on a per-update basis. See
                    # https://developers.google.com/chart/interactive/docs/gallery/bubblechart
                    # for option documentation.
                    options = list(
                      fontName = "Source Sans Pro",
                      fontSize = 13,
                      # Set axis labels and ranges
                      hAxis = list(
                        title = "Percent.ExpChange",    # "Health expenditure, per capita ($USD)"
                        format = "Percent",             # format number as a percentage :)
                        # color = "green",
                        # count = "4",
                        # legendPosition = "in",
                        # titlePosition = "in", axisTitlesPosition = "in",
                        # textposition = "in",
                        viewWindow = xlim
                      ),
                      vAxis = list(
                        title = "Unit.ExpChange",      # "Life expectancy (years)"
                        format = "Currency",           # format number as a $ :)
                        # legendPosition = "in",
                        # titlePosition = "in", 
                        # textposition = "in",
                        # ticks = "500,1000,1500,2000"     # would allow you to denote the lines at certain values
                        viewWindow = ylim
                      ),
                      # The default padding is a little too spaced out
                      chartArea = list(
                        top = 50, left = 75,
                        height = "75%", width = "75%"  # wierd the way this works
                      ),
                      # Allow pan/zoom
                      explorer = list(),
                      # Set bubble visual props
                      bubble = list(
                        opacity = 0.4, stroke = "none",
                        # Hide bubble label by having color of "none"
                        # code takes first column of data and uses as bubble title
                        textStyle = list(
                          fontSize = 12,
                          fontName = "Times-Roman",
                          color = "none",      # interesting idea if we can get bubble sizes worked out
                          bold = "true",
                          italic = "true",
                          auracolor = "none"   # whether there is padding around the bubble title or not
                        )
                      ),
                      # Set fonts
                      titleTextStyle = list(
                        fontSize = 16
                      ),
                      tooltip = list(
                        textStyle = list(
                          fontSize = 12
                        )
                      )
                    )
  ),
  fluidRow(
    shiny::column(4, offset = 4,
                  sliderInput("year", "Year",
                              min = min(data$Year), max = max(data$Year),
                              value = min(data$Year), animate = TRUE)
    )
  )
))