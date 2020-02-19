# R Telemetry

This is an RStudio addin that collects and sends telemetry data about errors you get while writing R code. It records the text of the error message and the stack trace as given by [`rlang::last_trace`](https://rlang.r-lib.org/reference/last_error.html) along with a timestamp and randomly generated identifier.

We are collecting this data to guide the development of tools to help data scientists learn to debug R programs. We appreciate your help!

## Setup

```r
devtools::install_github('willcrichton/rtelemetry')
```
