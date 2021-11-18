rm(list=ls())
library(readr)
library(tidyverse)
library(dplyr)
library(stringr)
library(shiny)

# Downloading and joining the data 

demo_2019 <- read_csv("..\\data\\WICounty2019Demographics.csv", skip = 1) %>%
    select(-matches("(Margin)|(Percent)|(ratio)|(_1)"), -id) %>%
    select(matches("(Total population)|(Geographic Area)")) %>%
    select(-matches("Hispanic or Latino \\(of any race\\)!!"), 
           -matches("American Indian and Alaska Native!!"),
           -matches("Asian!!"),
           -matches("Native Hawaiian and Other Pacific Islander!!"),
           -matches("Two or more races!"), 
           -matches("and over$"), 
           -matches("Race alone or in combination with one or more other races!!")) %>% 
    rename_all(funs(str_replace_all(., "((Estimate!!)|(Total population!!)+)", ""))) %>%
    rename(County = "Geographic Area Name") %>%
    mutate(County = sub(" County, Wisconsin", "", County))

#Income Data
income_2019 <- read_csv("..\\data\\WICounty2019Income.csv", na = "N", skip=1) %>%
    select(-id,-matches("(Margin)|(Distribution)")) %>%
    select(-matches("race"), -matches("FAMILIES!!families!!")) %>%
    rename_all(funs(str_replace_all(., "((Estimate!!)|(Number!!))+", ""))) %>%
    rename(County = "Geographic Area Name")%>%
    mutate(County = sub(" County, Wisconsin", "", County))

#Library Data
library_data <- readxl::read_excel("..\\data\\public_library_service_data_2019.xlsx", sheet = "2019 PRELIMINARY DATA", skip = 1) %>%
    slice(-1) %>%
    select(-c(
        "Library ID", 
        "Municipality",
        "Public Library System",
        "Branches", 
        "15. No. of Bookmobiles Owned", 
        "Other Service Outlets", 
        "Books-by-Mail", 
        "Joint Library under s.43.53 1=Yes", 
        "Participating Municipalities", 
        "Circulation Count Method: Actual / Survey", 
        "Locale Code", 
        "Other Material Description"), 
        -matches("(Outlay)|(Access Denied)|(Databases)|(Circulation)|(Collection Retrievals)")) 

data <- library_data %>%
    na_if("0") %>%
    left_join(demo_2019, by="County") %>%
    inner_join(income_2019, by="County") 


# Creating 3 primary tables 
programs_staff <- data %>%
    select(County, matches("(Number .*Program)|(Staff)"), "Total Income") %>%
    drop_na() %>%
    rename_all(funs(str_replace_all(., " ", "_"))) %>%
    mutate(across(.cols=-c(County), as.numeric)) %>%
    group_by(County) %>%
    mutate(across(.cols=everything(), sum)) %>%
    unique() 

library_income_costs <- data %>%
    select(County, "Total Income", 
           "Salaries & Wages", 
           "Print Materials", 
           "Electronic format", 
           "Audiovisual Materials", 
           "Contracted Services", 
           "Other Operating Expenditures", 
           "Total Operating Expenditures", 
           "Resident Support per Capita (Local Revenues and Resident Population)") %>%
    rename(Library_Income = `Total Income`) %>%
    rename_all(funs(str_replace_all(., " ", "_"))) %>%
    rename(Resident_Support_per_Capita = `Resident_Support_per_Capita_(Local_Revenues_and_Resident_Population)`) %>%
    drop_na() %>%
    mutate(across(.cols=-c(County), as.numeric)) %>%
    group_by(County) %>%
    mutate(across(.cols=everything(), sum)) %>%
    unique()

computer_Usage_Data <- data %>%
    select(County, 
           matches("SEX AND AGE"), 
           -matches("(Male)|(Female)|(Median)"), 
           "Median income (dollars)!!FAMILIES!!Families", 
           "Median income (dollars)!!NONFAMILY HOUSEHOLDS!!Nonfamily households", 
           matches("Computers"), "Wireless Internet Uses", 
           "Library Visits") %>%
    drop_na() %>%
    rename(Total_Population = "SEX AND AGE!!Total population", 
           Income_Familes = "Median income (dollars)!!FAMILIES!!Families", 
           Income_NonFamily = "Median income (dollars)!!NONFAMILY HOUSEHOLDS!!Nonfamily households") %>%
    rename_all(funs(str_replace_all(., "((SEX AND AGE!!)|( years))+", ""))) %>%
    rename_all(funs(str_replace_all(., " ", "_"))) %>%
    mutate(across(.cols=-c(County), as.numeric)) %>%
    group_by(County)  %>%
    mutate(across(.cols=everything(), sum), 
           Uses_per_Computer = Uses_of_Public_Internet_Computers/Number_of_Public_Use_Computers, 
           Uses_per_Computer_with_Internet = Uses_of_Public_Internet_Computers/Number_of_Public_Use_Computers_with_Internet_Access)%>%
    unique()


computer_usage_graph <- computer_Usage_Data %>%
    left_join(library_income_costs, by="County") %>%
    select("Total_Population", "Uses_per_Computer", "Library_Visits", "Income_Familes", "Wireless_Internet_Uses", "Income_NonFamily", "County") %>%
    pivot_longer(cols = c("Income_Familes", "Income_NonFamily"), names_to = "Income_Type", values_to = "Income")




















# Define UI for dataset viewer app ----
ui <- fluidPage(
    
    # App title ----
    titlePanel("Shiny Text"),
    
    # Sidebar layout with a input and output definitions ----
    sidebarLayout(
        
        # Sidebar panel for inputs ----
        sidebarPanel(
            
            # Input: Selector for choosing dataset ----
            selectInput(inputId = "dataset",
                        label = "Choose a dataset:",
                        choices = c("Computer Usage", "Wireless Usage", "Library Visits")),
            
            # # Input: Numeric entry for number of obs to view ----
            # numericInput(inputId = "obs",
            #              label = "Number of observations to view:",
            #              value = 10)
        ),
        
        # Main panel for displaying outputs ----
        mainPanel(
            
            # Output: plot with request y axis 
            plotOutput(outputId = "distPlot")
            
        )
    )
)

# Define server logic to summarize and view selected dataset ----
server <- function(input, output) {
    
    # Return the requested dataset ----
    datasetInput <- reactive({
        switch(input$dataset,
               "Computer Usage" = computer_usage_graph$Uses_per_Computer/computer_usage_graph$Total_Population,
               "Wireless Usage" = computer_usage_graph$Wireless_Internet_Uses/computer_usage_graph$Total_Population,
               "Library Visits" = computer_usage_graph$Library_Visits/computer_usage_graph$Total_Population)
    })
    
    output$distPlot <- renderPlot({
        
        ggplot(computer_usage_graph, aes(x = computer_usage_graph$Income, y = datasetInput())) + 
        geom_point() + 
        labs(x = "Income (dollars)", y = input$dataset, paste(input$dataset, "v. County Population")) + 
        geom_smooth(method = lm, se=FALSE, color="red") + 
        facet_wrap(~Income_Type)
        
    })
    
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)