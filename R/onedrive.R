#'
#' Find required file/s
#' 
#' @param onedrive
#' @param src
#' @param dest
#' @param overwrite
#' 

onedrive_download_item <- function(onedrive, src, dest, overwrite = FALSE) {
  ## Check if dest exists ----
  if (!file.exists(dest)) {
    ## Look for file in personal files ----
    pfiles <- onedrive$list_files()

    if (src %in% pfiles$name) {
      onedrive$download_file(src, dest = dest, overwrite = overwrite)
    } else {
      item_list <- onedrive$list_shared_files()
    
      onedrive_item <- lapply(
        X = item_list, 
        FUN = function(x) {
          x$get_path() |>
            grepl(pattern = src, x = _)
        }
      ) |>
        unlist() |>
        (\(x) item_list[x])() |>
        (\(x) x[[1]])()

      onedrive_item$download(dest = dest, overwrite = overwrite)
    }
  }

  dest
}



