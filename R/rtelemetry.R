server_url <- 'http://35.247.79.150:8888'

# Generate a random session ID once when the addin loads
session_id <- paste(sample(LETTERS, 16, replace=TRUE), collapse='')

get_timestamp <- function() {
  as.numeric(as.POSIXct(Sys.time()))
}

trace_to_json <- function(trace) {
  json <- list(
    session=session_id,
    timestamp=get_timestamp(),
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
    json <- trace_to_json(trace)
    tryCatch({
      httr::POST(server_url, body=json, encode='json', httr::timeout(0.2))
    }, error = function(e) {
      # for now, ignore any http issues
    })
  }

  options(error = error_handler)
}
