#' @title Min-max Scaling on Numeric Values to a New Range and Compute Summary Statistics
#'
#' @description Scales a numeric vector to fit within a range using min-max scaling and compute summary (mean, median and std)
#'
#' @param x A numeric vector to be scaled. Named 'x' because of the base R convention on function parameters.
#'
#' @param lower_limit A numeric value specifying the minimum value for scaling, tells the user directly about the parameter
#'
#' @param upper_limit A numeric value specifying the maximum value for scaling, tells the user directly about the parameter
#'
#' @param na.rm Indicating whether NA values should be removed. Followed base R convention on NA values.
#'
#' @examples
#' x <- c(1, 2, 5, 50, 100, NA)
#' shrink_and_summarize(x, lower_limit = 0, upper_limit = 10)
#' y <- c(1, 2, 5, 50, 100, NA)
#' shrink_and_summarize(x, lower_limit = 0, upper_limit = 10, na.rm = TRUE)
#' @return A list containing two elements:
#'   \item{prepared}{A numeric vector of the same length as input 'x', with values
#'   scaled to the range. NA values in input remain NA in output.}
#'   \item{summary}{A data frame with summary statistics (mean, median, sd) of the
#'   scaled values.}
#' @export

shrink_and_summarize <- function(x, lower_limit, upper_limit, na.rm = TRUE) {
  # Handle inappropriate values
  stopifnot(is.numeric(x))
  if (!is.numeric(lower_limit) || !is.numeric(upper_limit)) {
    stop("Both lower_limit and upper_limit must be numeric values.")
  }
  if (upper_limit <= lower_limit) {
    stop("upper_limit must be greater than lower_limit.")
  }

  prepared <- x
  old_range <- range(x, na.rm = TRUE)

  # Min max scaling
  if (diff(old_range) == 0) {
    prepared[!is.na(prepared)] <- mean(c(lower_limit, upper_limit))  # handle zero case and x length 1
  } else {
    prepared[!is.na(prepared)] <- (prepared[!is.na(prepared)] - old_range[1]) / diff(old_range) * (upper_limit - lower_limit) + lower_limit
  }

  stats <- data.frame(
    statistic = c("mean", "median", "sd"),
    value = c(
      mean(prepared, na.rm = na.rm),
      median(prepared, na.rm = na.rm),
      sd(prepared, na.rm = na.rm)
    )
  )

  return(list(
    prepared = prepared,
    summary = stats
  ))
}
