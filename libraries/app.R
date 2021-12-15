# Reading in the Data 
#Demographic Data
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
           Income_Families = "Median income (dollars)!!FAMILIES!!Families", 
           Income_NonFamily = "Median income (dollars)!!NONFAMILY HOUSEHOLDS!!Nonfamily households") %>%
    rename_all(funs(str_replace_all(., "((SEX AND AGE!!)|( years))+", ""))) %>%
    rename_all(funs(str_replace_all(., " ", "_"))) %>%
    mutate(across(.cols=-c(County), as.numeric)) %>%
    group_by(County)  %>%
    mutate(across(.cols=c("Number_of_Public_Use_Computers", "Number_of_Public_Use_Computers_with_Internet_Access", "Uses_of_Public_Internet_Computers", "Wireless_Internet_Uses", "Library_Visits"), sum), 
           Uses_per_Computer = Uses_of_Public_Internet_Computers/Number_of_Public_Use_Computers, 
           Uses_per_Computer_with_Internet = Uses_of_Public_Internet_Computers/Number_of_Public_Use_Computers_with_Internet_Access)%>%
    unique() 

data2 <- data %>%
    select(County, 
           `SEX AND AGE!!Total population`, 
           `SEX AND AGE!!Median age (years)`, 
           `Median income (dollars)!!FAMILIES!!Families`, 
           `Median income (dollars)!!NONFAMILY HOUSEHOLDS!!Nonfamily households`, 
           `Library Visits`, 
           `Total Income`, 
           `Number of Public Use Computers`, 
           `Uses of Public Internet Computers`) %>%
    drop_na() %>%
    mutate(across(.cols=-c(County), as.numeric), 
           County = tolower(County)) %>%
    rename(Total_Population = (`SEX AND AGE!!Total population`), 
           Median_Age = (`SEX AND AGE!!Median age (years)`), 
           Family_Income = `Median income (dollars)!!FAMILIES!!Families`, 
           NonFamily_Income = `Median income (dollars)!!NONFAMILY HOUSEHOLDS!!Nonfamily households`) %>%
    group_by(County) %>%
    mutate(num_libraries = n(), 
           Library_Visits = sum(`Library Visits`), 
           Library_Income = sum(`Total Income`), 
           Num_Computers = sum(`Number of Public Use Computers`), 
           Computer_Usage = sum(`Uses of Public Internet Computers`)) %>%
    select(-matches(" ")) %>%
    unique()



# COUNTY DATA EXPLORATION

county_1 <- ggplot(data2, aes(Total_Population/1000)) + 
    geom_histogram(color = "black", fill = "grey") + 
    labs(x = "County Population (1k Residents)", y = "Count", title = "County Populations") +
    scale_x_continuous(breaks = seq(0, 1000, 100))

county_2 <- map_data("county")%>%
    filter(region == "wisconsin")%>%
    left_join(data2, by=c("subregion"="County")) %>% 
    ggplot(aes(x = long, y = lat, outline = subregion, fill = Total_Population)) +
    geom_polygon(colour = "grey50") +
    scale_fill_continuous(type = "viridis", na.value = "grey80") + 
    theme(axis.line=element_blank(),
          axis.text=element_blank(),
          axis.ticks=element_blank(),
          axis.title=element_blank(),
          panel.background=element_blank(),
          panel.border=element_blank(),
          panel.grid=element_blank()) + 
    labs(title = "Total Population for Wisconsin Counties", fill = "Total Population")

county_3 <- map_data("county")%>%
    filter(region == "wisconsin")%>%
    left_join(data2, by=c("subregion"="County")) %>% 
    ggplot(aes(x = long, y = lat, outline = subregion, fill = Median_Age)) +
    geom_polygon(colour = "grey50") +
    scale_fill_continuous(type = "viridis", na.value = "grey80") + 
    theme(axis.line=element_blank(),
          axis.text=element_blank(),
          axis.ticks=element_blank(),
          axis.title=element_blank(),
          panel.background=element_blank(),
          panel.border=element_blank(),
          panel.grid=element_blank()) + 
    labs(title = "Median Age for Wisconsin Counties", fill = "Median Age")

county_4 <- map_data("county")%>%
    filter(region == "wisconsin")%>%
    left_join(data2, by=c("subregion"="County")) %>% 
    ggplot(aes(x = long, y = lat, outline = subregion, fill = Family_Income)) +
    geom_polygon(colour = "grey50") +
    scale_fill_continuous(type = "viridis", na.value = "grey80") + 
    theme(axis.line=element_blank(),
          axis.text=element_blank(),
          axis.ticks=element_blank(),
          axis.title=element_blank(),
          panel.background=element_blank(),
          panel.border=element_blank(),
          panel.grid=element_blank()) + 
    labs(title = "Median Family Income for Wisconsin Counties", fill = "Median Family \nIncome (dollars)")


# LIBRARY DATA EXPLORATION

lib_1 <- ggplot(data2, aes(x = Total_Population, y = Library_Visits)) + 
    geom_point() + 
    labs(x = "Library Visits", y = "County Population", title = "Library Visits vs. County Population")

lib_2 <- ggplot(data2, aes(y = Library_Income, x = Total_Population)) + 
    geom_point() + 
    labs(x = "Library Income", y = "County Population", title = "Library Income vs. County Population")

lib_3 <- ggplot(data2) + 
    geom_point(aes(x = Library_Income, y = NonFamily_Income, colour = "Non-Family Income")) + 
    geom_point(aes(x = Library_Income, y = Family_Income, colour = "Family Inncome")) + 
    labs(x = "Library Funding", y = "Median Income", title = "The Relationship between Income and Library Funding")

lib_4 <- ggplot(data2, aes(Library_Income/num_libraries/100000)) + 
    geom_histogram(color = "black", fill = "grey") + 
    labs(x = "Library Funding (100k dollars)", y = "Count", title = "Average Library Funding for each County") 

# RELATIONSHIPS

rel_1 <- ggplot(data2, aes(Total_Population/Num_Computers)) +
    geom_histogram(color = "black", fill = "grey") + 
    labs(x = "Population Served by each Computer", y = "Count", title = "Average Population Served by each Computer") +
    scale_x_continuous(breaks = seq(0, 3000, 500))

rel_2 <- ggplot(data2, aes(y = Total_Population, x = Num_Computers)) + 
    geom_point() 

rel_3 <- ggplot(data2, aes(Computer_Usage/Num_Computers/Total_Population)) + 
    geom_histogram(color = "black", fill = "grey") + 
    labs(x = "Computer Usage", y = "Count", title = "Computer Usages per County", subtitle = "Normalized by Number of Computers and County Population")

# Dropdown Options for UI
group = c(rep("County Data", 4), rep("Library Data", 4), rep("Library-County Relationship", 3))
graph = c("County Populations", 
          "Total Population for Wisconsin Counties (Map)", 
          "Median Age for Wisconsin Counties (Map)", 
          "Median Family Income for Wisconsin Counties (Map)",
          "Library Visits vs. County Population", 
          "Library Income vs. County Population", 
          "The Relationship between Income and Library Funding", 
          "Average Library Funding for each County", 
          "Population Served by each Computer", 
          "Total Population vs. Number of Computers", 
          "Computer Usages per County")
df <- data.frame(group, graph)




# Define UI for dataset viewer app ----
ui <- fluidPage(
    
    # App title ----
    titlePanel("STAT 433: Libraries"),
    
    # Sidebar layout with a input and output definitions ----
    sidebarLayout(
        
        # Sidebar panel for inputs ----
        sidebarPanel(
            
            # Input: Selector for choosing dataset ----
            selectInput(inputId = "group",
                        label = "Choose a dataset to explore:",
                        # choices = c("Computer Usage", "Wireless Usage", "Library Visits")
                        choices = df$group),
            
            selectInput(inputId = "graph",
                        label = "Choose a Graph:",
                        choices = df$graph)
        ),
        
        # Main panel for displaying outputs ----
        mainPanel(
            
            plotOutput(outputId = "distPlot")
            
        )
    )
)

# Define server logic to summarize and view selected dataset ----
server <- function(input, output, session) {
    
    graph.choice <- reactive({
        df %>%
            filter(group == input$group)
    })
    
    observe(({
        updateSelectInput(session, "graph", choices = graph.choice())
    }))
    tab <- reactive({
        df %>%
            filter(group == input$group)
    })
    
    output$table <- renderTable({
        tab()
    })
    
    output$distPlot <- renderPlot({
        switch(input$graph, 
               "County Populations" = county_1, 
               "Total Population for Wisconsin Counties (Map)" = county_2, 
               "Median Age for Wisconsin Counties (Map)" = county_3, 
               "Median Family Income for Wisconsin Counties (Map)" = county_4,
               "Library Visits vs. County Population" = lib_1, 
               "Library Income vs. County Population" = lib_2, 
               "The Relationship between Income and Library Funding" = lib_3, 
               "Average Library Funding for each County" = lib_4, 
               "Population Served by each Computer" = rel_1, 
               "Total Population vs. Number of Computers" = rel_2, 
               "Computer Usages per County" = rel_3 )
    })
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)