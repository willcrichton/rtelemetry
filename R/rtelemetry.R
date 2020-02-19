server_url <- 'http://35.247.79.150:8888'

# Generate a random session ID once when the addin loads
session_id <- paste(sample(LETTERS, 16, replace=TRUE), collapse='')

rtelemetry_path <- path.expand('~/.rtelemetry')

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

register_error_handler <- function() {
  options(error = error_handler)
}

#' @export
profile_init <- function() {
  if (file.exists(rtelemetry_path)) {
    register_error_handler()
  }
}

#' @export
install_profile <- function() {
  profile_path <- path.expand(file.path("~", ".Rprofile"))
  write("rtelemetry::profile_init()\n", file=profile_path, append=TRUE)
}

#' @export
rtelemetry_enable <- function() {
  file.create(rtelemetry_path)
  register_error_handler()
  cat("Enabled R telemetry.")
}

#' @export
rtelemetry_disable <- function() {
  file.remove(rtelemetry_path)
  options(error = NULL)
  cat("Disabled R telemetry.")
}

cat("rtelemetry loaded.")
