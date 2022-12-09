
library(dplyr)
library(anytime)
library(tidyverse)
library(stringr)
library(ggplot2)

co2_data <- read.csv("owid-co2-data.csv")

co2_per_year <- co2_data %>%
  select(country, co2, year, nitrous_oxide) %>% 
  # filter(country != "World") %>% 
  na.omit()

check <- function(select_year, search){
  
    co2_per_year <-co2_per_year %>%
      filter(country == search) %>% 
      filter(year >= select_year[1] & year <= select_year[2])
    #   filter(grepl(text(), show_title))
  
  return(co2_per_year)
}

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
    avg_gas_co2 <- round(avg_gas_co2, digits = 4)
    return(avg_gas_co2)
  })
  
  output$plot <- renderPlotly({
    title <- "CO2 Emissions Plot"
    
    co2_per_year <- check(input$select_year, 
                           input$select_country)
    #creating the plot for shows in america
    co2_plot <- co2_per_year %>% 
      ggplot(aes(x= year, y= !!as.name(input$select_gas))) +
      geom_count(aes(color = country), size = 0.5)+
      # coord_flip()+
      xlab("Year")+
      ylab("Gas")+
      ggtitle("Greenhouse gas emissions per country over the years")+ 
      labs(caption = "The greenhouse gas emissions per country, based on the year.")
    #viewing the plot
    return(co2_plot)
    # Be sure and return the completed plot!
    
  })
  
}
