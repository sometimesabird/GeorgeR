#' Check and Update Package from GitHub
#'
#' Internal function to check for package updates and install if available
#'
#' @param quiet Logical. Whether to suppress messages
#' @keywords internal
CheckAndUpdatePackage <- function(quiet = FALSE) {
#' Check and Update Package from GitHub
#'
#' Internal function to check for package updates and install if available
#'
#' @param quiet Logical. Whether to suppress messages
#' @keywords internal
CheckAndUpdatePackage <- function(quiet = FALSE) {

  # Hard-coded GitHub repository - update this to your actual repo
  github_repo <- "sometimesabird/GeorgeR"

  if (!requireNamespace("devtools", quietly = TRUE)) {
    if (!quiet) message("devtools not available - skipping update check")
    return(invisible(NULL))
  }

  # Get current version
  current_version <- utils::packageVersion("GeorgeR")

  tryCatch({
    if (!quiet) message("Checking for GeorgeR updates...")

    # Install from GitHub (this will only update if there's a newer version)
    devtools::install_github(github_repo, quiet = quiet, upgrade = "never")

    # Check if version changed
    new_version <- utils::packageVersion("GeorgeR")
    if (new_version > current_version && !quiet) {
      message("GeorgeR updated from ", current_version, " to ", new_version)
      message("Restart R session to use the new version")
    } else if (!quiet) {
      message("GeorgeR is up to date (version ", current_version, ")")
    }

  }, error = function(e) {
    if (!quiet) message("Update check failed: ", e$message)
  })

  invisible(NULL)
}

#' Prepare Environment for Analysis
#'
#' This function loads all the necessary objects into memory and sets up
#' the environment for both R scripts and R Markdown documents.
#'
#' @param rmarkdown Logical. TRUE if file is an Rmarkdown document,
#'   FALSE if it is a regular script
#' @param fig.dims Numeric vector of length 2. For Rmarkdown you can pass
#'   a vector of (width, height) for default size of figures in a chunk.
#'   Default is NULL.
#' @param update Logical. If TRUE, automatically checks for and installs
#'   package updates from GitHub. Default is FALSE.
#' @param quiet Logical. If TRUE, suppresses update messages.
#'   Default is FALSE.
#' @return Invisible NULL. Function is called for its side effects.
#' @export
#' @examples
#' \dontrun{
#' # For R Markdown with auto-updates
#' PrepareEnvironment(rmarkdown = TRUE, fig.dims = c(8, 6), update = TRUE)
#'
#' # For regular R scripts without auto-updates
#' PrepareEnvironment(rmarkdown = FALSE, update = FALSE)
#'
#' # Quiet updates
#' PrepareEnvironment(rmarkdown = TRUE, update = TRUE, quiet = TRUE)
#' }
#' Check and Update Package from GitHub
#'
#' Internal function to check for package updates and install if available
#'
#' @param quiet Logical. Whether to suppress messages
#' @keywords internal
CheckAndUpdatePackage <- function(quiet = FALSE) {

  # Hard-coded GitHub repository - update this to your actual repo
  github_repo <- "sometimesabird/GeorgeR"

  if (!requireNamespace("devtools", quietly = TRUE)) {
    if (!quiet) message("devtools not available - skipping update check")
    return(invisible(NULL))
  }

  # Get current version
  current_version <- utils::packageVersion("GeorgeR")

  tryCatch({
    if (!quiet) message("Checking for GeorgeR updates...")

    # Install from GitHub (this will only update if there's a newer version)
    devtools::install_github(github_repo, quiet = quiet, upgrade = "never")

    # Check if version changed
    new_version <- utils::packageVersion("GeorgeR")
    if (new_version > current_version && !quiet) {
      message("GeorgeR updated from ", current_version, " to ", new_version)
      message("Restart R session to use the new version")
    } else if (!quiet) {
      message("GeorgeR is up to date (version ", current_version, ")")
    }

  }, error = function(e) {
    if (!quiet) message("Update check failed: ", e$message)
  })

  invisible(NULL)
}

#' Prepare Environment for Analysis
#'
#' This function loads all the necessary objects into memory and sets up
#' the environment for both R scripts and R Markdown documents.
#'
#' @param fig.dims Numeric vector of length 2. For Rmarkdown you can pass
#'   a vector of (width, height) for default size of figures in a chunk.
#'   Default is NULL.
#' @param update Logical. If TRUE, automatically checks for and installs
#'   package updates from GitHub. Default is FALSE.
#' @param quiet Logical. If TRUE, suppresses update messages.
#'   Default is FALSE.
#' @return Invisible NULL. Function is called for its side effects.
#' @export
#' @examples
#' \dontrun{
#' # For R Markdown with auto-updates
#' PrepareEnvironment(fig.dims = c(8, 6), update = TRUE)
#'
#' # For regular R scripts without auto-updates
#' PrepareEnvironment(update = FALSE)
#'
#' # Quiet updates
#' PrepareEnvironment(update = TRUE, quiet = TRUE)
#' }
PrepareEnvironment <- function(
    fig.dims = NULL,
    update = FALSE,
    quiet = FALSE
) {

  # Check for package updates if requested
  if (update) {
    CheckAndUpdatePackage(quiet)
  }

  if (!requireNamespace("here", quietly = TRUE)) {
    utils::install.packages("here")
  }

  # Always try to set chunk options - only affects R Markdown
  if (requireNamespace("knitr", quietly = TRUE)) {
    inputPath <- knitr::current_input()
    if (is.null(inputPath)) inputPath <- "interactive"
    fileName <- tools::file_path_sans_ext(basename(inputPath))

    knitr::opts_chunk$set(
      echo = FALSE,
      class.output = "output",
      class.message = 'output',
      warning = FALSE,
      message = FALSE,
      cache = TRUE,
      cache.path = here::here("cache/markdown", fileName, "/"),
      fig.path = paste0(here::here("cache/figures/", fileName, "/"), "")
    )
    if (!is.null(fig.dims)) {
      knitr::opts_chunk$set(fig.width=fig.dims[1], fig.height=fig.dims[2])
    }
  }

  # These options are harmless in regular R
  options(dplyr.summarise.inform = FALSE)

  # Meta tags only work in R Markdown anyway
  if (requireNamespace("metathis", quietly = TRUE)) {
    tryCatch({
      metathis::meta() |>
        metathis::meta_robots(robots = 'noindex')
    }, error = function(e) NULL) # Silently fail if not in R Markdown
  }

  source(here::here('src/load_data.R'))

  invisible(NULL)
}
