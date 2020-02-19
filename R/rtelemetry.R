# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

trace_to_json <- function(trace) {
  json <- list(
    message=trace$message,
    trace=lapply(trace$trace$calls, toString)
  )
  jsonlite::toJSON(json)
}

#' @export
rtelemetryAddin <- function() {
  cat("Enabling R telemetry")

  error_handler <- function(...) {
    rlang::entrace(...)
    trace <- rlang::last_trace()
    cat(trace_to_json(trace))
  }

  options(error = error_handler)
}
