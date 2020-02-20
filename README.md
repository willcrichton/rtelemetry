# R Telemetry

This is an RStudio addin that collects and sends telemetry data about errors you get while writing R code. It records the text of the error message and the stack trace as given by [`rlang::last_trace`](https://rlang.r-lib.org/reference/last_error.html) along with a timestamp and randomly generated identifier.

We are collecting this data to guide the development of tools to help data scientists learn to debug R programs. We appreciate your help!

## Setup

Run these commands in RStudio:

```r
install.packages('devtools')
devtools::install_github('willcrichton/rtelemetry')
rtelemetry::install_profile()
```

If you're using RStudio Cloud, refresh the webpage once before proceeding.

## Usage

At the beginning of your development session, open the Addins menu in RStudio.

![](https://raw.githubusercontent.com/willcrichton/rtelemetry/master/assets/step1.png)

Then click "Enable R Telemetry" from the dropdown. You're good to go!

![](https://raw.githubusercontent.com/willcrichton/rtelemetry/master/assets/step2.png)
