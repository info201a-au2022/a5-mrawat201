
# ui.R
library(shiny)
library(plotly)

library(shinythemes)

introduction_page <- tabPanel(
  "Introduction",
  titlePanel("Introduction"),
  h3("Topic Introduction"),
  p("This webpage explores greenhouse gas emissions, including CO2 and N2O and trends in comparison to different countries and causes.
    The variables I have chosen to analyze are CO2, gas co2, and nitrous oxide, specifically the change in nitrous oxide,
    the average gas co2 in the world over the years, and the country with the largest emissions of CO2. These specific
    variables were chosen because the impact of greenhouse gases should be acknowledged, and different countries and governments
    should be informed in order to create change."),
  h3("Values"),
  p("The first value I calculated was which area of the world has the most CO2 emissions, according to the most 
    recent year. This variable is an important calculation because areas of the world and goverments need to be held
    accountable and aware of the effect their country is having on the world. The countries with the highest CO2
    emissions are:"),
  textOutput("variable_1"),
  p("These are countries that don't adhere to an agreement that saves governments money by allowing results of safety
    tests about medicine and pesticides to be shared. OECD is an agreement that requires appropriate testing. I calculated the second value when I looked at the nitrous oxide column and noticed the growth of the gas 
    over the years. Thus, the change in concentration of nitrous oxide gas over the years in the world is:"),
  textOutput("variable_2"),
  p("This large growth in nitrous oxide is alarming because it is a more potent gas than CO2 and can have a large 
    impact on global warming if the gas continues to increase in atmosphere. The next value I calculated was the average gas co2 in the the world over the years, to measure the amount of impact
    cars and vehicles have on the Earth. The average concentration of gas co2 in the world over the years is:"),
  textOutput("variable_3")
)
min_co2_per_year <- co2_per_year %>% 
  filter(year == min(year, na.rm = TRUE)) %>% 
  filter(country == "World") %>% 
  pull(year)

max_co2_per_year <- co2_per_year %>% 
  filter(year == max(year, na.rm = TRUE)) %>% 
  filter(country == "World") %>% 
  pull(year)

chart_sidebar_content <- sidebarPanel(
  input_text <- textInput(
    inputId = "select_country",
    label = "Select a country to see CO2 emission",
    value = "World"
  ),
  input_year <- sliderInput("select_year", "Year Range:",
              min = min_co2_per_year, max = max_co2_per_year,
              value = c(min_co2_per_year,max_co2_per_year),
              sep =""
              ),
  input_gas <-  selectInput(
    inputId = "select_gas",
    label = "Select Gas Emission",
    choices = list("CO2" = "co2", "Nitrous Oxide" = "nitrous_oxide"),
    selected = "co2"
  )
)

?sliderInput()
chart_main_content <- mainPanel(
  plotlyOutput("plot")
)

chart_panel <- tabPanel(
  "CO2 emission",
  titlePanel("CO2 emission over the years"),
  chart_sidebar_content,
  chart_main_content,
  p("This chart displays different greenhouse gas emissions over the years, based on the country. This is an
    important graphic because it allows for different countries and their citizens to be informed
    on the impact that their society is having on the world in comparison to other areas of the world.")
)


ui <- navbarPage(
  theme = shinytheme("darkly"),
  "A5",
  introduction_page,
  chart_panel
)

?textOutput()
