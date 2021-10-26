DataSource
================
Celina Ough, Maya Tunney, Robert George
10/25/2021

This Census Data contains information on the breakdown of household
types and income for counties in Wisconsin. For example, this data
includes the median income for families, single people, and married
couples in the county.

## Wisconsin Demographic Data

[Link to County
Demographics](https://data.census.gov/cedsci/table?q=Race%20demographics&g=0400000US55%240600000&tid=ACSDP1Y2019.DP05&moe=false&hidePreview=false)

This is census data about the demographics of counties in Wisconsin. It
includes information on race, age, and sex. There are many columns in
the dataset since each category (race, age, sex) is is divided into many
categories so for ease of readibility we will only show the first
sixteen column names which detail the sex and age categories.

``` r
WI_data <- read_csv("..\\data\\WICounty2019Demographics.csv", skip = 1) %>%
  select(-matches("Margin"), 
         -matches("Percent"), 
         -matches("ratio"),
         -id) %>%
  select(matches("Total population"), 
         -matches("_1")) %>%
  rename_all(funs(str_replace_all(., "Estimate!!", ""))) %>%
  rename_all(funs(str_replace_all(., "Total population!!", "")))

head(WI_data[,1:4])
```

    ## # A tibble: 6 x 4
    ##   `SEX AND AGE!!Total ~ `SEX AND AGE!!Ma~ `SEX AND AGE!!Fem~ `SEX AND AGE!!Unde~
    ##                   <dbl>             <dbl>              <dbl>               <dbl>
    ## 1                104565             51514              53051                7217
    ## 2                259673            127994             131679               11673
    ## 3                 66778             31566              35212                3797
    ## 4                 99933             47693              52240                6311
    ## 5                590157            284873             305284               41749
    ## 6                 76747             37283              39464                4145

``` r
colnames(WI_data)[1:16]
```

    ##  [1] "SEX AND AGE!!Total population"  "SEX AND AGE!!Male"             
    ##  [3] "SEX AND AGE!!Female"            "SEX AND AGE!!Under 5 years"    
    ##  [5] "SEX AND AGE!!5 to 9 years"      "SEX AND AGE!!10 to 14 years"   
    ##  [7] "SEX AND AGE!!15 to 19 years"    "SEX AND AGE!!20 to 24 years"   
    ##  [9] "SEX AND AGE!!25 to 34 years"    "SEX AND AGE!!35 to 44 years"   
    ## [11] "SEX AND AGE!!45 to 54 years"    "SEX AND AGE!!55 to 59 years"   
    ## [13] "SEX AND AGE!!60 to 64 years"    "SEX AND AGE!!65 to 74 years"   
    ## [15] "SEX AND AGE!!75 to 84 years"    "SEX AND AGE!!85 years and over"

## Wisconsin Public Library Data

[Link to Library Data](https://dpi.wi.gov/pld/data-reports/service-data)

This dataset includes information about Public Libraries in Wisconsin.
It includes information about funding, location, hours, resources and
how the public utilizes the library. This dataset contains 102 columns
so for ease of readibility we will only show 17 column names that detail
the usage of the library programs.

``` r
library_data <- readxl::read_excel("..\\data\\public_library_service_data_2019.xlsx", sheet = "2019 PRELIMINARY DATA", skip = 1) %>%
  slice(-1) %>%
  select(-c("Library ID", "Branches", "15. No. of Bookmobiles Owned", 
            "Other Service Outlets", "Books-by-Mail", "Joint Library under s.43.53 1=Yes", 
            "Circulation Count Method: Actual / Survey", "Locale Code"), 
         -matches("Outlay"), -matches("Access Denied"), -matches("Databases")) 

head(library_data[,1:4])
```

    ## # A tibble: 6 x 4
    ##   `Public Library`          Municipality County `Public Library System` 
    ##   <chr>                     <chr>        <chr>  <chr>                   
    ## 1 Beloit Public Library     Beloit       Rock   Arrowhead Library System
    ## 2 Clinton Public Library    Clinton      Rock   Arrowhead Library System
    ## 3 Eager Free Public Library Evansville   Rock   Arrowhead Library System
    ## 4 Edgerton Public Library   Edgerton     Rock   Arrowhead Library System
    ## 5 Hedberg Public Library    Janesville   Rock   Arrowhead Library System
    ## 6 Milton Public Library     Milton       Rock   Arrowhead Library System

``` r
colnames(library_data)[27:44]
```

    ##  [1] "Children's E-Content Use"          "Total E-Content Use"              
    ##  [3] "Resident Registered Borrowers"     "Nonresident Registered Borrowers" 
    ##  [5] "Total Registered Borrowers"        "Reference Transactions"           
    ##  [7] "Library Visits"                    "Uses of Public Internet Computers"
    ##  [9] "Wireless Internet Uses"            "Number of Website Visits"         
    ## [11] "Number of Children's Programs"     "Children's Program Attendance"    
    ## [13] "Number of Young Adult Programs"    "Young  Adult Program Attendance"  
    ## [15] "Number of Other Programs"          "Other Program Attendance"         
    ## [17] "Total Number of Programs"          "Total Program Attendance"
