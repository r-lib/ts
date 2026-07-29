#' @details
#' \eval{tsitter:::format_rd_parser_list(tsitter:::ts_list_parsers())}
#' @keywords internal
#' @return
#' Not applicable.
#' @seealso [About tsitter][about].
#'
#' Useful links:
#'
#' * <https://github.com/r-lib/tsitter>
#' * <https://r-lib.github.io/tsitter/>
#' * Report bugs at <https://github.com/r-lib/tsitter/issues>
"_PACKAGE"

## usethis namespace: start
#' @useDynLib tsitter, .registration = TRUE, .fixes = "c_"
## usethis namespace: end
NULL

## usethis namespace: start
## usethis namespace: end
NULL

#' @name about
#' @title About tsitter
#' @description
#' tsitter is a common interface to [tree-sitter](
#'  https://tree-sitter.github.io/tree-sitter/) parsers, implemented in
#' other R packages. It has a common API to
#'
#' - query,
#' - edit,
#' - format, and
#' - unserialize
#'
#' tree-sitter parse trees.
#'
#' @return
#' Not applicable.
#'
#' @details
#'
#' ```{r, child = "tools/man/about.Rmd"}
#' ```
NULL
