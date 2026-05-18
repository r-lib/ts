#' Show the syntax tree of a tree-sitter tree
#'
#' @description
#' Show the structure of a tree-sitter tree as an S-expression.
#'
#' @details
#' This function returns a nested list representation of the syntax tree,
#' where each node is represented as a list with its type and children.
#'
#' @param tree
#' A `ts_tree` object.
#'
#' @return
#' A string representing the S-expression of the syntax tree.
#'
#' @export
#' @family ts_tree exploration
#' @family ts_tree generics
#' @examplesIf requireNamespace("tsjsonc", quietly = TRUE)
#' # Create a parse tree with tsjsonc -------------------------------------
#' tree <- tsjsonc::ts_parse_jsonc(
#'   "{ \"a\": //comment\ntrue, \"b\": [1, 2, 3] }"
#' )
#'
#' ts_tree_sexpr(tree)
#'
#' @examplesIf requireNamespace("tstoml", quietly = TRUE)
#'
#' # Create a parse tree with tstoml --------------------------------------
#' tree <- tstoml::ts_parse_toml(r"(
#'   [servers]
#'   alpha = { ip = "127.0.0.1", dc = "eqdc10" }
#'   beta = { ip = "127.0.0.2", dc = "eqdc20" }
#' )")
#'
#' ts_tree_sexpr(tree)

ts_tree_sexpr <- function(tree) {
  UseMethod("ts_tree_sexpr")
}

#' @export

ts_tree_sexpr.default <- function(tree) {
  call_with_cleanup(c_s_expr, tree)
}
