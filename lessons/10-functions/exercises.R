# Simple functions:
average <- function(x) {
  sum(x) / length(x)
}
variance <- function(x) {
  sum((x - average(x))^2) / (length(x) - 1)
}
skew <- function(x) {
  m2 <- variance(x)
  m3 <- sum((x - average(x))^3) * (1 / (length(x) - 2))
  m3 / (m2^(3/2))
}

