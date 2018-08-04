
Fars Package
============

The goal of fars is the data from the US National Highway Traffic Safety Administration's [Fatality Analysis Reporting System](https://www.nhtsa.gov/Data/Fatality-Analysis-Reporting-System-(FARS)), which is a nationwide census providing the American public yearly data regarding fatal injuries suffered in motor vehicle traffic crashes.

Installation
------------

You can install fars from github with:

``` r
# install.packages("devtools")
devtools::install_github("BreizhZut/Fars")
```

Example
-------

In oder to work properly one need to check the data location.

``` r
fars_dir = file.path("..","data")
list.files(fars_dir)
```

    ## [1] "accident_2013.csv.bz2" "accident_2014.csv.bz2" "accident_2015.csv.bz2"

File names are regenerated with a simple method

``` r
file.path(fars_dir,"accident_2013.csv.bz2")
```

    ## [1] "../data/accident_2013.csv.bz2"

``` r
library(fars)
```

    ## No methods found in package 'dplyr' for request: 'bind_rows' when loading 'fars'

    ## No methods found in package 'dplyr' for request: 'group_by' when loading 'fars'

    ## No methods found in package 'dplyr' for request: 'mutate' when loading 'fars'

    ## No methods found in package 'dplyr' for request: 'select' when loading 'fars'

    ## No methods found in package 'dplyr' for request: 'summarize' when loading 'fars'

``` r
file2013 <- make_filename(2013,path=fars_dir)
file2013
```

    ## [1] "../data/accident_2013.csv.bz2"

And then loaded

``` r
data2013 <- fars_read(file2013)
head(data2013)
```

    ## # A tibble: 6 x 50
    ##   STATE ST_CASE VE_TOTAL VE_FORMS PVH_INVL  PEDS PERNOTMVIT PERMVIT
    ##   <int>   <int>    <int>    <int>    <int> <int>      <int>   <int>
    ## 1     1   10001        1        1        0     0          0       8
    ## 2     1   10002        2        2        0     0          0       2
    ## 3     1   10003        1        1        0     0          0       1
    ## 4     1   10004        1        1        0     0          0       3
    ## 5     1   10005        2        2        0     0          0       3
    ## 6     1   10006        2        2        0     0          0       3
    ## # ... with 42 more variables: PERSONS <int>, COUNTY <int>, CITY <int>,
    ## #   DAY <int>, MONTH <int>, YEAR <int>, DAY_WEEK <int>, HOUR <int>,
    ## #   MINUTE <int>, NHS <int>, ROAD_FNC <int>, ROUTE <int>, TWAY_ID <chr>,
    ## #   TWAY_ID2 <chr>, MILEPT <int>, LATITUDE <dbl>, LONGITUD <dbl>,
    ## #   SP_JUR <int>, HARM_EV <int>, MAN_COLL <int>, RELJCT1 <int>,
    ## #   RELJCT2 <int>, TYP_INT <int>, WRK_ZONE <int>, REL_ROAD <int>,
    ## #   LGT_COND <int>, WEATHER1 <int>, WEATHER2 <int>, WEATHER <int>,
    ## #   SCH_BUS <int>, RAIL <chr>, NOT_HOUR <int>, NOT_MIN <int>,
    ## #   ARR_HOUR <int>, ARR_MIN <int>, HOSP_HR <int>, HOSP_MN <int>,
    ## #   CF1 <int>, CF2 <int>, CF3 <int>, FATALS <int>, DRUNK_DR <int>
