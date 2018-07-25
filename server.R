library(shinydashboard)
library(shiny)
library(ggplot2)
library(dplyr)
library(DT)
library(reshape2)

shinyServer(function(input, output) ({ 

output$genretime <- renderPlot({
woo = vgames %>% group_by(Year_of_Release, Genre) %>% 
    summarise(total = sum(Global_Sales))

GT = woo %>% group_by(Year_of_Release) %>%
    top_n(3)    
  
ggplot(GT, aes(x=Year_of_Release, y=total)) + geom_bar(stat='Identity', aes(fill=Genre))})


output$consolewar <- renderPlot({ 
ggplot(woop, aes(x = Year_of_Release, y = total)) + geom_bar(stat = 'Identity', aes(fill = console_type))})

output$toppubs <- renderPlot({
ggplot(Regional_Sales, aes(x = Year_of_Release, y = total)) + geom_point(data = toppubs, aes(col = Publisher)) + geom_line(data = toppubs, aes(col = Publisher, group = Publisher))})

output$Region <- renderPlot({
count = vgames %>% group_by(Year_of_Release) %>% summarise(NA_Sales=sum(NA_Sales),
                                                  EU_Sales=sum(EU_Sales),
                                                  JP_Sales=sum(JP_Sales),
                                                  Other = sum(Other_Sales))
  
count_long = melt(count, id="Year_of_Release") 
  
ggplot(data=count_long,
aes(x=Year_of_Release, y=value, group=variable, colour=variable)) +
geom_line()})

output$rating <- renderTable({
vgames %>% filter(Year_of_Release == input$Year) %>% select(Year_of_Release, Name, Platform, Critic_Score) %>% arrange(desc(Critic_Score)) %>% head(10)
})

output$The_Overview <- renderTable({
vgames %>% filter(Year_of_Release == input$Year) %>% select(Year_of_Release, Name, Platform, Global_Sales) %>% top_n(10, wt = Global_Sales)
})

}))















  
  
  

  
    
  
  
  
    
  


