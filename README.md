
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

Dependencies

``` r
library(dplyr)
library(readr)
library(tidyr)
library(magrittr)
library(maps)
```

Loading the library

``` r
library(fars)
```

Example: reading a file
-----------------------

In oder to work properly one need to check the data location.

``` r
fars_dir = file.path("tests","data")
list.files(fars_dir)
```

    ## [1] "accident_2013.csv.bz2" "accident_2014.csv.bz2" "accident_2015.csv.bz2"

This packaque contains a function to build standard names

``` r
file2013 <- make_filename(2013)
file2013
```

    ## [1] "accident_2013.csv.bz2"

The `fars_read` function reads the file, the optionnal argument `fars_path` unables the user to specify the directory cotainong the data.

``` r
library(knitr)
data2013 <- fars_read(file2013,fars_path=fars_dir)
kable(head(data2013))
```

|  STATE|  ST\_CASE|  VE\_TOTAL|  VE\_FORMS|  PVH\_INVL|  PEDS|  PERNOTMVIT|  PERMVIT|  PERSONS|  COUNTY|  CITY|  DAY|  MONTH|  YEAR|  DAY\_WEEK|  HOUR|  MINUTE|  NHS|  ROAD\_FNC|  ROUTE| TWAY\_ID         | TWAY\_ID2            |  MILEPT|  LATITUDE|   LONGITUD|  SP\_JUR|  HARM\_EV|  MAN\_COLL|  RELJCT1|  RELJCT2|  TYP\_INT|  WRK\_ZONE|  REL\_ROAD|  LGT\_COND|  WEATHER1|  WEATHER2|  WEATHER|  SCH\_BUS| RAIL    |  NOT\_HOUR|  NOT\_MIN|  ARR\_HOUR|  ARR\_MIN|  HOSP\_HR|  HOSP\_MN|  CF1|  CF2|  CF3|  FATALS|  DRUNK\_DR|
|------:|---------:|----------:|----------:|----------:|-----:|-----------:|--------:|--------:|-------:|-----:|----:|------:|-----:|----------:|-----:|-------:|----:|----------:|------:|:-----------------|:---------------------|-------:|---------:|----------:|--------:|---------:|----------:|--------:|--------:|---------:|----------:|----------:|----------:|---------:|---------:|--------:|---------:|:--------|----------:|---------:|----------:|---------:|---------:|---------:|----:|----:|----:|-------:|----------:|
|      1|     10001|          1|          1|          0|     0|           0|        8|        8|     115|     0|    6|      1|  2013|          1|     0|      55|    1|          1|      1| I-59             | NA                   |    1589|  33.79196|  -86.38370|        0|        42|          0|        0|        1|         1|          0|          4|          2|        10|         0|       10|         0| 0000000 |         99|        99|          1|         7|        99|        99|    0|    0|    0|       2|          0|
|      1|     10002|          2|          2|          0|     0|           0|        2|        2|      55|  1670|    3|      1|  2013|          5|    21|      24|    1|          2|      2| US-SR 74         | MCCLAIN ST           |    1397|  33.98466|  -85.88831|        0|        12|          6|        0|        2|         2|          0|          1|          3|        10|         0|       10|         0| 0000000 |         99|        99|         21|        33|        99|        99|    0|    0|    0|       1|          0|
|      1|     10003|          1|          1|          0|     0|           0|        1|        1|      89|  1730|    6|      1|  2013|          1|    11|      45|    0|         15|      6| OAKWOOD AVE      | NA                   |       0|  34.74947|  -86.62147|        0|        30|          0|        0|        1|         1|          0|          4|          1|        10|         0|       10|         0| 0000000 |         99|        99|         11|        54|        99|        99|    0|    0|    0|       1|          0|
|      1|     10004|          1|          1|          0|     0|           0|        3|        3|      73|   350|    6|      1|  2013|          1|    12|      25|    0|         99|      6| JEFFERSON AVE SW | NA                   |       0|  33.48591|  -86.85701|        0|        24|          0|        0|        1|         1|          0|          4|          1|         1|         0|        1|         0| 0000000 |         99|        99|         12|        33|        99|        99|    0|    0|    0|       2|          0|
|      1|     10005|          2|          2|          0|     0|           0|        3|        3|     125|  3050|    6|      1|  2013|          1|    18|      28|    1|         11|      1| I-359            | NA                   |      10|  33.16856|  -87.55183|        0|        12|          1|        1|       18|         1|          0|          1|          3|         1|         0|        1|         0| 0000000 |         99|        99|         18|        29|        99|        99|    0|    0|    0|       1|          0|
|      1|     10006|          2|          2|          0|     0|           0|        3|        3|      97|  2100|    8|      1|  2013|          3|    14|      31|    1|         13|      6| GOVERNMENT ST    | PLEASANT VALLEY ROAD |       0|  30.66168|  -88.10793|        0|        12|          6|        0|        2|         2|          0|          1|          1|         1|         0|        1|         0| 0000000 |         99|        99|         14|        32|        99|        99|    0|    0|    0|       1|          0|

[![Build Status](https://travis-ci.org/BreizhZut/Fars.svg?branch=master)](https://travis-ci.org/BreizhZut/Fars)
