#' Write a tree-sitter tree to a file
#'
#' @description
#' Writes the document of a ts `ts_tree` object to a file or connection.
#'
#' @details
#' If `tree` was created from a file, then `ts_tree_write()` by default
#' writes it back to the same file. Otherwise, the `file` argument must be
#' specified.
#'
#' To write to a connection, pass a connection object to the `file`
#' argument. If the connection is opened in binary mode, the raw bytes
#' are written using [base::writeBin()]. Otherwise, the raw bytes are
#' converted to characters using the system encoding before writing using
#' [base::rawToChar()].
#'
#' </p><p><!-- ------------------------------------------------------>
#'
#' Use `file = stdout()` to write to the standard output, i.e. to the
#' console in an interactive R session.
#'
#' @param tree
#'  A `ts_tree` object as returned by
#' \code{\link[tsitter:ts_tree_new]{ts_tree_new()}}.
#' @param file
#' Character string, connection, or `NULL`. The file or connection
#' to write to. By default it writes to the same file that was used in
#' \code{\link[tsitter:ts_tree_new]{ts_tree_new()}}, if `tree` was read from a
#' file.
#'
#' @return
#' Invisibly returns `NULL`.
#'
#' @family ts_tree generics
#' @export
#' @examplesIf Sys.getenv("IN_PKGDOWN") == "true"
#' # Create a parse tree with tsjsonc -------------------------------------
#' tree <- tsjsonc::ts_parse_jsonc('{"foo": 42, "bar": [1, 2, 3]}')
#'
#' # Format and write to file
#' ts_tree_write(ts_tree_format(tree), "example.json")

ts_tree_write <- function(tree, file = NULL) {
  UseMethod("ts_tree_write")
}

#' @export

ts_tree_write.default <- function(tree, file = NULL) {
  file <- file %||% attr(tree, "file")
  if (is.null(file)) {
    lang <- toupper(get_tree_lang(tree))
    stop(ts_cnd(
      "Don't know which file to save {lang} document to. You need to \\
       specify the `file` argument."
    ))
  }

  text <- attr(tree, "text")
  if (length(text) > 0 && text[length(text)] != 0xa) {
    text <- c(text, as.raw(0xa))
  }
  if (inherits(file, "connection")) {
    if (grepl("b", summary(file)$mode)) {
      writeBin(text, con = file)
    } else {
      cat(rawToChar(text), file = file)
    }
  } else {
    writeBin(text, con = file)
  }
  invisible()
}
