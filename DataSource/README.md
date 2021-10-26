DataSource
================
Celina Ough, Maya Tunney, Robert George
10/25/2021

## Short description of County Data

This is census data with Demographic data from counties in Wisconsin. It
includes information on race, age, and sex.

This Census Data contains information on the breakdown of household
types and income for counties in Wisconsin. For example, this data
includes the median income for families, single people, and married
couples in the county.

This dataset includes information about Public Libraries in Wisconsin.
It includes information about funding, location, hours, resources and
how the public utilizes the library.

## Short description of Library Data

TBD

``` r
WI_data <- read_csv("..\\data\\WICounty2019Demographics.csv", skip = 1) %>%
  select(-matches("Margin"), 
         -matches("Percent"), 
         -matches("ratio"), 
         -id)

head(WI_data)
```

    ## # A tibble: 6 x 87
    ##   `Geographic Are~ `Estimate!!SEX ~ `Estimate!!SEX ~ `Estimate!!SEX ~
    ##   <chr>                       <dbl>            <dbl>            <dbl>
    ## 1 Green Bay city,~           104565            51514            53051
    ## 2 Madison city, D~           259673           127994           131679
    ## 3 Eau Claire city~            66778            31566            35212
    ## 4 Kenosha city, K~            99933            47693            52240
    ## 5 Milwaukee city,~           590157           284873           305284
    ## 6 Racine city, Ra~            76747            37283            39464
    ## # ... with 83 more variables: `Estimate!!SEX AND AGE!!Total population!!Under 5
    ## #   years` <dbl>, `Estimate!!SEX AND AGE!!Total population!!5 to 9
    ## #   years` <dbl>, `Estimate!!SEX AND AGE!!Total population!!10 to 14
    ## #   years` <dbl>, `Estimate!!SEX AND AGE!!Total population!!15 to 19
    ## #   years` <dbl>, `Estimate!!SEX AND AGE!!Total population!!20 to 24
    ## #   years` <dbl>, `Estimate!!SEX AND AGE!!Total population!!25 to 34
    ## #   years` <dbl>, `Estimate!!SEX AND AGE!!Total population!!35 to 44
    ## #   years` <dbl>, `Estimate!!SEX AND AGE!!Total population!!45 to 54
    ## #   years` <dbl>, `Estimate!!SEX AND AGE!!Total population!!55 to 59
    ## #   years` <dbl>, `Estimate!!SEX AND AGE!!Total population!!60 to 64
    ## #   years` <dbl>, `Estimate!!SEX AND AGE!!Total population!!65 to 74
    ## #   years` <dbl>, `Estimate!!SEX AND AGE!!Total population!!75 to 84
    ## #   years` <dbl>, `Estimate!!SEX AND AGE!!Total population!!85 years and
    ## #   over` <dbl>, `Estimate!!SEX AND AGE!!Total population!!Median age
    ## #   (years)` <dbl>, `Estimate!!SEX AND AGE!!Total population!!Under 18
    ## #   years` <dbl>, `Estimate!!SEX AND AGE!!Total population!!16 years and
    ## #   over` <dbl>, `Estimate!!SEX AND AGE!!Total population!!18 years and
    ## #   over` <dbl>, `Estimate!!SEX AND AGE!!Total population!!21 years and
    ## #   over` <dbl>, `Estimate!!SEX AND AGE!!Total population!!62 years and
    ## #   over` <dbl>, `Estimate!!SEX AND AGE!!Total population!!65 years and
    ## #   over` <dbl>, `Estimate!!SEX AND AGE!!Total population!!18 years and
    ## #   over_1` <dbl>, `Estimate!!SEX AND AGE!!Total population!!18 years and
    ## #   over!!Male` <dbl>, `Estimate!!SEX AND AGE!!Total population!!18 years and
    ## #   over!!Female` <dbl>, `Estimate!!SEX AND AGE!!Total population!!65 years and
    ## #   over_1` <dbl>, `Estimate!!SEX AND AGE!!Total population!!65 years and
    ## #   over!!Male` <dbl>, `Estimate!!SEX AND AGE!!Total population!!65 years and
    ## #   over!!Female` <dbl>, `Estimate!!RACE!!Total population` <dbl>,
    ## #   `Estimate!!RACE!!Total population!!One race` <dbl>, `Estimate!!RACE!!Total
    ## #   population!!Two or more races` <dbl>, `Estimate!!RACE!!Total
    ## #   population!!One race_1` <dbl>, `Estimate!!RACE!!Total population!!One
    ## #   race!!White` <dbl>, `Estimate!!RACE!!Total population!!One race!!Black or
    ## #   African American` <dbl>, `Estimate!!RACE!!Total population!!One
    ## #   race!!American Indian and Alaska Native` <dbl>, `Estimate!!RACE!!Total
    ## #   population!!One race!!American Indian and Alaska Native!!Cherokee tribal
    ## #   grouping` <chr>, `Estimate!!RACE!!Total population!!One race!!American
    ## #   Indian and Alaska Native!!Chippewa tribal grouping` <chr>,
    ## #   `Estimate!!RACE!!Total population!!One race!!American Indian and Alaska
    ## #   Native!!Navajo tribal grouping` <chr>, `Estimate!!RACE!!Total
    ## #   population!!One race!!American Indian and Alaska Native!!Sioux tribal
    ## #   grouping` <chr>, `Estimate!!RACE!!Total population!!One race!!Asian` <dbl>,
    ## #   `Estimate!!RACE!!Total population!!One race!!Asian!!Asian Indian` <chr>,
    ## #   `Estimate!!RACE!!Total population!!One race!!Asian!!Chinese` <chr>,
    ## #   `Estimate!!RACE!!Total population!!One race!!Asian!!Filipino` <chr>,
    ## #   `Estimate!!RACE!!Total population!!One race!!Asian!!Japanese` <chr>,
    ## #   `Estimate!!RACE!!Total population!!One race!!Asian!!Korean` <chr>,
    ## #   `Estimate!!RACE!!Total population!!One race!!Asian!!Vietnamese` <chr>,
    ## #   `Estimate!!RACE!!Total population!!One race!!Asian!!Other Asian` <chr>,
    ## #   `Estimate!!RACE!!Total population!!One race!!Native Hawaiian and Other
    ## #   Pacific Islander` <dbl>, `Estimate!!RACE!!Total population!!One
    ## #   race!!Native Hawaiian and Other Pacific Islander!!Native Hawaiian` <chr>,
    ## #   `Estimate!!RACE!!Total population!!One race!!Native Hawaiian and Other
    ## #   Pacific Islander!!Guamanian or Chamorro` <chr>, `Estimate!!RACE!!Total
    ## #   population!!One race!!Native Hawaiian and Other Pacific
    ## #   Islander!!Samoan` <chr>, `Estimate!!RACE!!Total population!!One
    ## #   race!!Native Hawaiian and Other Pacific Islander!!Other Pacific
    ## #   Islander` <chr>, `Estimate!!RACE!!Total population!!One race!!Some other
    ## #   race` <dbl>, `Estimate!!RACE!!Total population!!Two or more races_1` <dbl>,
    ## #   `Estimate!!RACE!!Total population!!Two or more races!!White and Black or
    ## #   African American` <chr>, `Estimate!!RACE!!Total population!!Two or more
    ## #   races!!White and American Indian and Alaska Native` <chr>,
    ## #   `Estimate!!RACE!!Total population!!Two or more races!!White and
    ## #   Asian` <chr>, `Estimate!!RACE!!Total population!!Two or more races!!Black
    ## #   or African American and American Indian and Alaska Native` <chr>,
    ## #   `Estimate!!Race alone or in combination with one or more other races!!Total
    ## #   population` <dbl>, `Estimate!!Race alone or in combination with one or more
    ## #   other races!!Total population!!White` <dbl>, `Estimate!!Race alone or in
    ## #   combination with one or more other races!!Total population!!Black or
    ## #   African American` <dbl>, `Estimate!!Race alone or in combination with one
    ## #   or more other races!!Total population!!American Indian and Alaska
    ## #   Native` <dbl>, `Estimate!!Race alone or in combination with one or more
    ## #   other races!!Total population!!Asian` <dbl>, `Estimate!!Race alone or in
    ## #   combination with one or more other races!!Total population!!Native Hawaiian
    ## #   and Other Pacific Islander` <chr>, `Estimate!!Race alone or in combination
    ## #   with one or more other races!!Total population!!Some other race` <chr>,
    ## #   `Estimate!!HISPANIC OR LATINO AND RACE!!Total population` <dbl>,
    ## #   `Estimate!!HISPANIC OR LATINO AND RACE!!Total population!!Hispanic or
    ## #   Latino (of any race)` <dbl>, `Estimate!!HISPANIC OR LATINO AND RACE!!Total
    ## #   population!!Hispanic or Latino (of any race)!!Mexican` <chr>,
    ## #   `Estimate!!HISPANIC OR LATINO AND RACE!!Total population!!Hispanic or
    ## #   Latino (of any race)!!Puerto Rican` <chr>, `Estimate!!HISPANIC OR LATINO
    ## #   AND RACE!!Total population!!Hispanic or Latino (of any race)!!Cuban` <chr>,
    ## #   `Estimate!!HISPANIC OR LATINO AND RACE!!Total population!!Hispanic or
    ## #   Latino (of any race)!!Other Hispanic or Latino` <chr>, `Estimate!!HISPANIC
    ## #   OR LATINO AND RACE!!Total population!!Not Hispanic or Latino` <dbl>,
    ## #   `Estimate!!HISPANIC OR LATINO AND RACE!!Total population!!Not Hispanic or
    ## #   Latino!!White alone` <dbl>, `Estimate!!HISPANIC OR LATINO AND RACE!!Total
    ## #   population!!Not Hispanic or Latino!!Black or African American alone` <dbl>,
    ## #   `Estimate!!HISPANIC OR LATINO AND RACE!!Total population!!Not Hispanic or
    ## #   Latino!!American Indian and Alaska Native alone` <dbl>, `Estimate!!HISPANIC
    ## #   OR LATINO AND RACE!!Total population!!Not Hispanic or Latino!!Asian
    ## #   alone` <dbl>, `Estimate!!HISPANIC OR LATINO AND RACE!!Total population!!Not
    ## #   Hispanic or Latino!!Native Hawaiian and Other Pacific Islander
    ## #   alone` <dbl>, `Estimate!!HISPANIC OR LATINO AND RACE!!Total population!!Not
    ## #   Hispanic or Latino!!Some other race alone` <dbl>, `Estimate!!HISPANIC OR
    ## #   LATINO AND RACE!!Total population!!Not Hispanic or Latino!!Two or more
    ## #   races` <dbl>, `Estimate!!HISPANIC OR LATINO AND RACE!!Total population!!Not
    ## #   Hispanic or Latino!!Two or more races!!Two races including Some other
    ## #   race` <dbl>, `Estimate!!HISPANIC OR LATINO AND RACE!!Total population!!Not
    ## #   Hispanic or Latino!!Two or more races!!Two races excluding Some other race,
    ## #   and Three or more races` <dbl>, `Estimate!!Total housing units` <dbl>,
    ## #   `Estimate!!CITIZEN, VOTING AGE POPULATION!!Citizen, 18 and over
    ## #   population` <dbl>, `Estimate!!CITIZEN, VOTING AGE POPULATION!!Citizen, 18
    ## #   and over population!!Male` <dbl>, `Estimate!!CITIZEN, VOTING AGE
    ## #   POPULATION!!Citizen, 18 and over population!!Female` <dbl>

``` r
library_data <- readxl::read_excel("..\\data\\public_library_service_data_2019.xlsx", sheet = "2019 PRELIMINARY DATA", skip = 1) %>%
  slice(-1) %>%
  select(-c("Library ID", "Branches", "15. No. of Bookmobiles Owned", 
            "Other Service Outlets", "Books-by-Mail", "Joint Library under s.43.53 1=Yes", 
            "Circulation Count Method: Actual / Survey", "Locale Code"), 
         -matches("Outlay"), -matches("Access Denied"), -matches("Databases"))

head(library_data)
```

    ## # A tibble: 6 x 102
    ##   `Public Library` Municipality County `Public Library~ `Resident Popul~
    ##   <chr>            <chr>        <chr>  <chr>            <chr>           
    ## 1 Beloit Public L~ Beloit       Rock   Arrowhead Libra~ 36548           
    ## 2 Clinton Public ~ Clinton      Rock   Arrowhead Libra~ 2104            
    ## 3 Eager Free Publ~ Evansville   Rock   Arrowhead Libra~ 5413            
    ## 4 Edgerton Public~ Edgerton     Rock   Arrowhead Libra~ 5640            
    ## 5 Hedberg Public ~ Janesville   Rock   Arrowhead Libra~ 63433           
    ## 6 Milton Public L~ Milton       Rock   Arrowhead Libra~ 5540            
    ## # ... with 97 more variables: `Additional County Population` <chr>, `Extended
    ## #   County Population` <chr>, `Hours Open per Week Winter` <chr>, `Hours Open
    ## #   per Week Summer (When 0 use WIN_HRS_WK)` <chr>, `Annual Hours Open (All
    ## #   locations)` <chr>, `Square Footage of Library` <chr>, `Book and Serial
    ## #   Volumes in Print` <chr>, `Book and Serial Volumes in Print Added` <chr>,
    ## #   `Audio Materials` <chr>, `Audio Added` <chr>, `Video Materials` <chr>,
    ## #   `Video Added` <chr>, `Other Material` <chr>, `Other Material
    ## #   Description` <chr>, `Periodical Subscriptions` <chr>, `Number of Public Use
    ## #   Computers` <chr>, `Number of Public Use Computers with Internet
    ## #   Access` <chr>, `Children's Material Circulation` <chr>, `Total
    ## #   Circulation` <chr>, `ILL Loaned To` <chr>, `ILL Received From` <chr>,
    ## #   `Children's E-Content Use` <chr>, `Total E-Content Use` <chr>, `Resident
    ## #   Registered Borrowers` <chr>, `Nonresident Registered Borrowers` <chr>,
    ## #   `Total Registered Borrowers` <chr>, `Reference Transactions` <chr>,
    ## #   `Library Visits` <chr>, `Uses of Public Internet Computers` <chr>,
    ## #   `Wireless Internet Uses` <chr>, `Number of Website Visits` <chr>, `Number
    ## #   of Children's Programs` <chr>, `Children's Program Attendance` <chr>,
    ## #   `Number of Young Adult Programs` <chr>, `Young Adult Program
    ## #   Attendance` <chr>, `Number of Other Programs` <chr>, `Other Program
    ## #   Attendance` <chr>, `Total Number of Programs` <chr>, `Total Program
    ## #   Attendance` <chr>, `Librarians with ALA MLS` <chr>, `Other
    ## #   Librarians` <chr>, `Total Librarians` <chr>, `Other Paid Staff` <chr>,
    ## #   `Total Staff` <chr>, `Municipal Appropriation` <chr>, `Home County
    ## #   Appropriation` <chr>, `Other County Payments- Adjacent Counties` <chr>,
    ## #   `State Funds` <chr>, `Federal Funds` <chr>, `Contract Income` <chr>, `All
    ## #   Other Income` <chr>, `Total Income` <chr>, `Salaries & Wages` <chr>,
    ## #   `Employee Benefits` <chr>, `Print Materials` <chr>, `Electronic
    ## #   format` <chr>, `Audiovisual Materials` <chr>, `All Other Materials` <chr>,
    ## #   `Library Materials Total` <chr>, `Contracted Services` <chr>, `Other
    ## #   Operating Expenditures` <chr>, `Total Operating Expenditures` <chr>,
    ## #   `Exempt from County Library Tax` <chr>, `Resident Support per Capita (Local
    ## #   Revenues and Resident Population)` <chr>, `Total Nonresident
    ## #   Circulation` <chr>, `Home County Circulation to those with a
    ## #   library` <chr>, `Home County Circulation to those without a library` <chr>,
    ## #   `Home County Total Circulation` <chr>, `Other System Counties Circulation
    ## #   to those with a library` <chr>, `Other System Counties Circulation to those
    ## #   without a library` <chr>, `Other System Counties Total Circulation` <chr>,
    ## #   `Nonsystem Adjacent County Circulation to those with a library` <chr>,
    ## #   `Nonsystem Adjacent County Circulation to those without a library` <chr>,
    ## #   `Nonsystem Adjacent County Total Circulation` <chr>, `All Other State
    ## #   Residents Circulation` <chr>, `Users from Out of State Circulation` <chr>,
    ## #   `Participating Municipalities` <chr>, `Type of Library Organization` <chr>,
    ## #   `Locale Description` <chr>, `E-Books` <chr>, `Electronic Audio Materials
    ## #   (downloadable)` <chr>, `Electronic Video Materials (downloadable)` <chr>,
    ## #   `Uses of E-Books` <chr>, `Uses of E-Audio` <chr>, `Uses of E-Video` <chr>,
    ## #   `Local Electronic Collection Retrievals` <chr>, `Other Electronic
    ## #   Collection Retrievals (purchased by library system or consortia)` <chr>,
    ## #   `Statewide Electronic Collection Retrievals (provided through
    ## #   BadgerLink)` <chr>, `Total Electronic Collection Retrievals (local, system,
    ## #   and statewide)` <chr>, `Number of Self-directed Activities for Children
    ## #   0-11` <chr>, `Number of Self-directed Activities for Young Adults
    ## #   12-18` <chr>, `Number of Self-directed Activities for Other (all
    ## #   ages)` <chr>, `Total Number of Self-directed Activities` <chr>,
    ## #   `Participation in Self-directed Activities for Children 0-11` <chr>,
    ## #   `Participation in Self-directed Activities for Young Adults 12-18` <chr>,
    ## #   `Participation in Self-directed Activities for Other (all ages)` <chr>,
    ## #   `Total Participation in Self-directed Activities` <chr>

## Robert’s Code

### Library funding and demographics by Wisconsin county

This Census Data contains information on the breakdown of household
types and income for counties in Wisconsin. For example, this data
includes the median income for families, single people, and married
couples in the county, as well as median income by race.

This dataset includes information about Public Libraries in Wisconsin.
It includes information about funding, location, hours, resources and
how the public utilizes the library.
