Data for Stat 433
================
Celina Ough, Maya Tunney, Robert George

### Library funding and demographics by Wisconsin county

This Census Data contains information on the breakdown of household
types and income for counties in Wisconsin. For example, this data
includes the median income for families, single people, and married
couples in the county, as well as median income by race.

    ## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --

    ## v ggplot2 3.3.5     v dplyr   1.0.7
    ## v tibble  3.1.4     v stringr 1.4.0
    ## v tidyr   1.1.3     v forcats 0.5.1
    ## v purrr   0.3.4

    ## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
income_2019 <- read_csv("productDownload_2021-10-25T203440/ACSST1Y2019.S1903_data_with_overlays_2021-10-25T203421.csv", 
    na = "N",skip=1)%>%
  select(-id)%>%
  select(-matches("Margin"),-matches("Distribution"),-matches("FAMILY SIZE"))
```

    ## Rows: 24 Columns: 242

    ## -- Column specification --------------------------------------------------------
    ## Delimiter: ","
    ## chr  (12): id, Geographic Area Name, Estimate!!Median income (dollars)!!HOUS...
    ## dbl (226): Estimate!!Number!!HOUSEHOLD INCOME BY RACE AND HISPANIC OR LATINO...
    ## lgl   (4): Estimate!!Number!!HOUSEHOLD INCOME BY RACE AND HISPANIC OR LATINO...

    ## 
    ## i Use `spec()` to retrieve the full column specification for this data.
    ## i Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
colnames(income_2019) = gsub('Estimate!!Number!!HOUSEHOLD INCOME BY RACE AND HISPANIC OR LATINO ORIGIN OF HOUSEHOLDER!!', '', colnames(income_2019), fixed=TRUE)
colnames(income_2019) = gsub('Estimate!!Number!!HOUSEHOLD INCOME BY AGE OF HOUSEHOLDER!!', '', colnames(income_2019), fixed=TRUE)
colnames(income_2019) = gsub('Estimate!!Number!!FAMILIES!!', '', colnames(income_2019), fixed=TRUE)
colnames(income_2019) = gsub('Estimate!!Number!!NONFAMILY HOUSEHOLDS!!', '', colnames(income_2019), fixed=TRUE)
colnames(income_2019) = gsub('Estimate!!Number!!', '', colnames(income_2019), fixed=TRUE)
head(income_2019)
```

    ## # A tibble: 6 x 69
    ##   `Geographic Are~ Households `Households!!On~ `Households!!On~ `Households!!On~
    ##   <chr>                 <dbl>            <dbl>            <dbl>            <dbl>
    ## 1 Brown County, W~     107385            96742               NA               NA
    ## 2 Dane County, Wi~     229760           201395            10664               NA
    ## 3 Dodge County, W~      35104            34389               NA               NA
    ## 4 Eau Claire Coun~      41385            38800               NA               NA
    ## 5 Fond du Lac Cou~      42604            40480               NA               NA
    ## 6 Jefferson Count~      32783            31419               NA               NA
    ## # ... with 64 more variables: Households!!One race--!!Asian <dbl>,
    ## #   Households!!One race--!!Native Hawaiian and Other Pacific Islander <lgl>,
    ## #   Households!!One race--!!Some other race <dbl>,
    ## #   Households!!Two or more races <dbl>,
    ## #   Households!!Hispanic or Latino origin (of any race) <dbl>,
    ## #   Households!!White alone, not Hispanic or Latino <dbl>,
    ## #   15 to 24 years <dbl>, 25 to 44 years <dbl>, 45 to 64 years <dbl>, ...

This dataset includes information about Public Libraries in Wisconsin.
It includes information about funding, location, hours, resources and
how the public utilizes the library.

``` r
library(readxl)
libraries_2019 <- read_excel("PRELIMINARY_2019_public_library_service_data.xlsx", na = "-", skip = 1)[-1,]
head(libraries_2019)
```

    ## # A tibble: 6 x 133
    ##   `Library ID` `Public Library`          Municipality County `Public Library Sy~
    ##   <chr>        <chr>                     <chr>        <chr>  <chr>              
    ## 1 WI0025       Beloit Public Library     Beloit       Rock   Arrowhead Library ~
    ## 2 WI0061       Clinton Public Library    Clinton      Rock   Arrowhead Library ~
    ## 3 WI0099       Eager Free Public Library Evansville   Rock   Arrowhead Library ~
    ## 4 WI0091       Edgerton Public Library   Edgerton     Rock   Arrowhead Library ~
    ## 5 WI0142       Hedberg Public Library    Janesville   Rock   Arrowhead Library ~
    ## 6 WI0198       Milton Public Library     Milton       Rock   Arrowhead Library ~
    ## # ... with 128 more variables: Resident Population <chr>,
    ## #   Additional County Population <chr>, Extended County Population <chr>,
    ## #   Branches <chr>, 15. No. of Bookmobiles Owned <chr>,
    ## #   Other Service Outlets <chr>, Books-by-Mail <chr>,
    ## #   Hours Open per Week Winter <chr>,
    ## #   Hours Open per Week Summer (When 0 use WIN_HRS_WK) <chr>,
    ## #   Annual Hours Open (All locations) <chr>, ...
