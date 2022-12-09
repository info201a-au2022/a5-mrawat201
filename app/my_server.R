
library(dplyr)
library(anytime)
library(tidyverse)
library(stringr)
library(ggplot2)

co2_data <- read.csv("owid-co2-data.csv")
server <- function(input, output) {
  # 3 different values
  # Which area of the world has the most CO2 (in the current year)?
  
  output$variable_1 <- renderText({
    
    highest_co2_most_recent <- co2_data %>%
      filter(year == max(year)) %>%
      select(country, co2) %>% 
      filter(country != "World") %>% 
      filter(co2 == max(co2, na.rm = TRUE)) %>%
      pull(country)
    
    return(highest_co2_most_recent)
  })
  
  #   How much has nitrous oxide changed in the world over the years?
  output$variable_2 <- renderText({
   min_n2o_world <- co2_data %>%
     select(country, nitrous_oxide) %>% 
     filter(country == "World") %>% 
     filter(nitrous_oxide == min(nitrous_oxide, na.rm = TRUE)) %>% 
     pull(nitrous_oxide)
   max_n2o_world <- co2_data %>%
     select(country, nitrous_oxide) %>% 
     filter(country == "World") %>% 
     filter(nitrous_oxide == max(nitrous_oxide, na.rm = TRUE)) %>% 
     pull(nitrous_oxide)
   change_in_n2o_world <- max_n2o_world - min_n2o_world
    
    return(change_in_n2o_world)
  })
  #   What is the average gas co2 in the the world over the years?
  output$variable_3 <- renderText({
    avg_gas_co2 <- co2_data %>%
      select(country, gas_co2) %>% 
      filter(country == "World") %>% 
      summarize(gas_co2 = mean(gas_co2, na.rm = TRUE)) %>% 
      pull(gas_co2)
   
    return(avg_gas_co2)
  })
  
}
