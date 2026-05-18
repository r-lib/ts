#' Insert a new element into a tree-sitter tree
#'
#' @description
#' Insert a new element into each selected element.
#'
#' @details
#' It is not always possible to insert a new element into a selected
#' element. For example in a JSONC document you can only insert a new
#' element into an array or an object, but not into scalar elements.
#' If the insertion is not possible, an error is raised.
#'
#' If `tree` does not have a selection, the new element is inserted into
#' at the top level.
#'
#' If `tree` has an empty selection, then it is returned unchanged, i.e.
#' no new element is inserted.
#'
#' @param tree
#' A `ts_tree` object.
#' @param new
#' The new element to insert.
#'
#' The type of `new` depends on the parser and the method that implements
#' the insertion. See details in the manual of the specific parser.
#' @param key
#' The key of the new element, if inserting into a keyed element.
#'
#' For example a JSON(C) object or a TOML table are keyed elements.
#' @param at
#' The position to insert the new element at.
#'
#' The interpretation of this argument depends on the method that
#' implements the insertion. Typically the followings are supported:
#' - `0` inserts at the beginning.
#' - `Inf` inserts at the end.
#' - A positive integer `n` inserts _after_ the `n`-th element.
#' - A character scalar inserts _after_ the element with the given key,
#'   in keyed elements.
#'
#' See the details in the manual of the specific parser.
#' @param options
#' A list of options for the insertion.
#'
#' See details in the manual of the specific parser.
#' @param ... Extra arguments for methods.
#'
#' @return
#' A `ts_tree` object representing the modified parse tree.
#' @family ts_tree generics
#' @export
#' @examplesIf requireNamespace("tsjsonc", quietly = TRUE)
#' # Create a parse tree with tsjsonc -------------------------------------
#' tree <- tsjsonc::ts_parse_jsonc('{ "a": true, "b": [1, 2, 3] }')
#'
#' tree |> ts_tree_select("b") |> ts_tree_insert(4, at = Inf)
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
#' tree |>
#'   ts_tree_select("servers", TRUE) |>
#'   ts_tree_insert(key = "active", TRUE)

ts_tree_insert <- function(tree, new, key, at, options, ...) {
  UseMethod("ts_tree_insert")
}
