#'
#' Get list of small island developing states
#' 

get_sids <- function() {
  url <- "https://en.wikipedia.org/wiki/Small_Island_Developing_States"

  ## Initiate session ----
  session <- rvest::session(url = url)

  ## Extract SIDS data ----
  df <- session |>
    rvest::html_element(css = ".mw-parser-output") |>
    rvest::html_table() |>
    dplyr::select(1:3) |>
    dplyr::slice(1:29) |>
    apply(
      MARGIN = 2, 
      FUN = function(x) {
        as.vector(x) |>
          (\(x) x[x != ""])() |>
          stringr::str_remove_all(pattern = "\\[[a-z]{1}\\]") |>
          data.frame() |>
          stats::setNames(nm = "island")
      }
    ) |>
    dplyr::bind_rows(.id = "region") |>
    tibble::as_tibble()

  ## Return df ----
  df
}
