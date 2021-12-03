# Utility and background functions

# Defaults for NULL values; use a unless a is NULL, then use b
# Used if an argument is optional and there is a means to calculate the default
`%||%` <- function(a, b) if (is.null(a)) b else a

# Opposite of the above function; use a if it is NULL; otherwise, evaluate b
`%keepnull%` <- function(a, b) if (is.null(a)) a else b
