#' Format the selected elements of a tree sitter tree for printing
#'
#' @description
#' (Re)format the selected elements of the document represented by a
#' tree-sitter tree, if the tree-sitter parser supports formatting.
#'
#' @details
#' If `tree` does not have a selection, then the whole document is
#' formatted.
#'
#' If `tree` has an empty selection, then it is returned unchanged.
#'
#' Some parsers support options to customize the formatting.
#' See details in the manual of the specific parser.
#'
#' @param tree
#' A `ts_tree` object.
#'
#' @param options
#' A list of options for the formatting.
#'
#' See details in the manual of the specific parser.
#'
#' @param ... Extra arguments for methods.
#'
#' @return
#' A `ts_tree` object representing the reformatted document.
#'
#' @family ts_tree generics
#' @export
#' @examplesIf requireNamespace("tsjsonc", quietly = TRUE)
#' # Create a parse tree with tsjsonc -------------------------------------
#' tree <- tsjsonc::ts_parse_jsonc('{ "a":true, "b": [1,2,3] }')
#' tree
#'
#' # Format whole document
#' tree |> ts_tree_format()
#'
#' # Format each top element under the document node in one line
#' tree |> ts_tree_format() |>
#'   ts_tree_select(TRUE) |>
#'   ts_tree_format(options = list(format = "oneline"))
#'
#'
#' @examplesIf requireNamespace("tstoml", quietly = TRUE)
#' # Create a parse tree with tstoml --------------------------------------
#' tree <- tstoml::ts_parse_toml(r"(
#'   [servers]
#'   alpha = { ip = "127.0.0.1", dc = "eqdc10" }
#'   beta = { ip = "127.0.0.2", dc = "eqdc20" }
#' )")
#'
#' tree
#'
#' tree |> ts_tree_format()

ts_tree_format <- function(tree, options, ...) {
  UseMethod("ts_tree_format")
}
