#' Delete selected elements from a tree-sitter tree
#'
#' @description
#' Use \code{\link[tsitter:ts_tree_select]{ts_tree_select()}} to select the
#' elements to be deleted, and then call `ts_tree_delete()` to remove them
#' from the tree.
#'
#' @details
#' The formatting of the rest of the document is left as is.
#'
#' If the tree does not have a selection, the tree corresponding to the
#' empty document is returned, i.e. the whole content is deleted.
#'
#' If the tree has a selection, but it is the empty selection, then
#' the tree is returned unchanged.
#'
#' For parsers that support comments, deleting elements that include
#' comments typically delete the comments as well. Other comments are
#' kept as is. See details in the manual of the specific parser.
#'
#' @param tree
#' A `ts_tree` object.
#' @param ... Extra arguments for methods.
#'
#' @return
#' The modified `ts_tree` object with the selected elements removed.
#'
#' @family ts_tree generics
#' @export
#' @examplesIf requireNamespace("tsjsonc", quietly = TRUE)
#' # Create a parse tree with tsjsonc -------------------------------------
#' tree <- tsjsonc::ts_parse_jsonc(
#'   "{ \"a\": //comment\ntrue, \"b\": [1, 2, 3] }"
#' )
#'
#' tree
#'
#' tree |> ts_tree_select("a")
#'
#' tree |> ts_tree_select("a") |> ts_tree_delete()
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
#' tree |> ts_tree_select("servers", TRUE, "dc")
#' tree |> ts_tree_select("servers", TRUE, "dc") |> ts_tree_delete()

ts_tree_delete <- function(tree, ...) {
  UseMethod("ts_tree_delete")
}
