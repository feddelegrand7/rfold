
.get_files_that_are_not_in_r_folder <- function(folders_to_ignore) {

  r_folder_exists <- unname(fs::dir_exists(here::here("R")))

  if (!r_folder_exists) {
    message("R folder does not exist, creating it")
    fs::dir_create(here::here("R"))
  }

  r_folders <- list.dirs(here::here("R"))

  if (length(r_folders) > 1) {
    stop("Looks like you've folders insider your R folder, please inspect")
  }

  all_r_files <- fs::dir_ls(
    path = ".",
    regexp = ".R$|.r$",
    recurse = TRUE
  )

  tmp_df <- data.frame(
    r_files = all_r_files,
    dir_name = dirname(all_r_files),
    row.names = NULL
  )

  r_files_without_dir <- tmp_df[tmp_df$dir_name == ".", ]

  if (nrow(r_files_without_dir) > 0) {
    stop(
      "The following .R files are on the top-level
      of the package and don't have a parent directory, please inspect: ",
      toString(r_files_without_dir$r_files)
    )
  }

  folders_to_be_ignored <- c("R", "tests", "tests/testthat", folders_to_ignore)

  r_files_not_in_r_dir_df <- tmp_df[!tmp_df$dir_name %in% folders_to_be_ignored, ]

  r_files_not_in_r_dir <- r_files_not_in_r_dir_df$r_files

  if (length(r_files_not_in_r_dir) == 0) {
    cli::cli_alert_warning(
      "No R files available outside of the R directory, nothing to do"
    )
    return(character(0))
  }

  r_files_names_not_in_r_dir <- basename(r_files_not_in_r_dir)

  dupli <- duplicated(r_files_names_not_in_r_dir)

  duplicated_files <- r_files_names_not_in_r_dir[dupli]

  if (length(duplicated_files) > 0) {
    stop(
      "The following file(s) are duplicated across your package: ",
      toString(duplicated_files)
    )
  }

  r_files_not_in_r_dir

}


#' Transfer .R files into the R directory
#'
#' @return called for the side effect of transferring all R files
# available inside a project into the R folder
#' @param folders_to_ignore a string vector of plain names folders that should be ignored
#' where transferring .R files into the main R folder (for example a dev folder). Defaults to NULL
#'
#' @export
#'

fold <- function(folders_to_ignore = NULL) {

  if (!is.null(folders_to_ignore)) {
    if (any(grepl("/", folders_to_ignore))) {
      stop("Please provide plain folder names (without the backslash /)")
    }

    dir_exist <- dir.exists(folders_to_ignore)

    if (!any(dir_exist)) {
      dir_no_exist <- folders_to_ignore[!dir_exist]
      stop("The following directories do not exist. Can't ignore them: ", dir_no_exist)

    }
  }

  r_files <- .get_files_that_are_not_in_r_folder(folders_to_ignore)

  if (length(r_files) == 0) {
    return(invisible(NULL))
  }

  dir_components <- unique(unlist(strsplit(r_files, "/")))

  dir_components <- dir_components[!grepl("\\.R$", dir_components)]

  usethis::use_build_ignore(dir_components)

  r_files_string <- paste(toString(r_files), collapse = ", ")

  cli::cli_alert_info(
    "Copying the following R files into the R folder: {r_files_string}"
  )

  fs::file_copy(
    path = r_files,
    new_path = here::here("R"),
    overwrite = TRUE
  )

  cli::cli_alert_success("Success")
}

