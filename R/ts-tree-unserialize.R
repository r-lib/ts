#' Unserialize selected elements of a tree-sitter tree
#'
#' @description
#' Unserialize the selected elements of a `ts_tree` object, i.e. convert
#' them to R objects.
#'
#' @details
#' If no elements are selected in the tree, then the whole document is
#' unserialized.
#'
#' If the tree has an empty selection, then an empty list is returned.
#'
#' ## The `[[` operator
#'
#' The `[[` operator works similarly to the combination of
#' \code{\link[tsitter:ts_tree_select]{ts_tree_select()}} and
#' `ts_tree_unserialize()`, but it might be more readable.
#'
#' For the details on how the selected elements are mapped to R objects,
#' see the documentation of the methods in the parser packages. The methods
#' in the installed parser packages are linked below.
#'
#' @param tree
#' A `ts_tree` object.
#'
#' @return
#' List of R objects, with one entry for each selected element.
#'
#' @family ts_tree generics
#' @family serialization functions
#' @export
#' @examplesIf requireNamespace("tsjsonc", quietly = TRUE)
#' # Create a parse tree with tsjsonc -------------------------------------
#' tree <- tsjsonc::ts_parse_jsonc('{"a": 13, "b": [1, 2, 3], "c": "x"}')
#'
#' tree
#'
#' ts_tree_unserialize(ts_tree_select(tree, c("b", "c")))
#'
#' ts_tree_unserialize(ts_tree_select(tree, "b"))

ts_tree_unserialize <- function(tree) {
  UseMethod("ts_tree_unserialize")
}
