
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Min-max Scaling on Numeric Values to a New Range and Compute Summary Statistics

<!-- badges: start -->
<!-- badges: end -->

The goal of minmaxsummarize is to provide a function
`shrink_and_summarize` that can scale a numeric vector to fit within a
range using min-max scaling and compute summary (mean, median and std).

## Installation

You can install the development version of minmaxsummarize like so:

``` r
devtools::install_github("stat545ubc-2024/minmaxsummarize")
```

## Example

This is a basic example:

``` r
library(minmaxsummarize)
x <- c(1, 2, 5, 50, 100, NA)
shrink_and_summarize(x, 0, 10)
#> $prepared
#> [1]  0.0000000  0.1010101  0.4040404  4.9494949 10.0000000         NA
#> 
#> $summary
#>   statistic     value
#> 1      mean 3.0909091
#> 2    median 0.4040404
#> 3        sd 4.3846994
```
