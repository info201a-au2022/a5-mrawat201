
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

ui <- navbarPage(
  theme = shinytheme("darkly"),
  "A5",
  introduction_page
)

?textOutput()
