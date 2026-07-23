# Insert a new element into a tree-sitter tree

Insert a new element into each selected element.

## Usage

``` r
ts_tree_insert(tree, new, key, at, options, ...)
```

## Arguments

- tree:

  A `ts_tree` object.

- new:

  The new element to insert.

  The type of `new` depends on the parser and the method that implements
  the insertion. See details in the manual of the specific parser.

- key:

  The key of the new element, if inserting into a keyed element.

  For example a JSON(C) object or a TOML table are keyed elements.

- at:

  The position to insert the new element at.

  The interpretation of this argument depends on the method that
  implements the insertion. Typically the followings are supported:

  - `0` inserts at the beginning.

  - `Inf` inserts at the end.

  - A positive integer `n` inserts *after* the `n`-th element.

  - A character scalar inserts *after* the element with the given key,
    in keyed elements.

  See the details in the manual of the specific parser.

- options:

  A list of options for the insertion.

  See details in the manual of the specific parser.

- ...:

  Extra arguments for methods.

## Value

A `ts_tree` object representing the modified parse tree.

## Details

It is not always possible to insert a new element into a selected
element. For example in a JSONC document you can only insert a new
element into an array or an object, but not into scalar elements. If the
insertion is not possible, an error is raised.

If `tree` does not have a selection, the new element is inserted into at
the top level.

If `tree` has an empty selection, then it is returned unchanged, i.e. no
new element is inserted.

## See also

Other ts_tree generics:
[`[[.ts_tree()`](https://r-lib.github.io/tsitter/reference/double-bracket-ts-tree.md),
[`[[<-.ts_tree()`](https://r-lib.github.io/tsitter/reference/double-bracket-set-ts-tree.md),
[`format.ts_tree()`](https://r-lib.github.io/tsitter/reference/format.ts_tree.md),
[`print.ts_tree()`](https://r-lib.github.io/tsitter/reference/print.ts_tree.md),
[`select-set`](https://r-lib.github.io/tsitter/reference/select-set.md),
[`ts_tree_ast()`](https://r-lib.github.io/tsitter/reference/ts_tree_ast.md),
[`ts_tree_delete()`](https://r-lib.github.io/tsitter/reference/ts_tree_delete.md),
[`ts_tree_dom()`](https://r-lib.github.io/tsitter/reference/ts_tree_dom.md),
[`ts_tree_format()`](https://r-lib.github.io/tsitter/reference/ts_tree_format.md),
[`ts_tree_new()`](https://r-lib.github.io/tsitter/reference/ts_tree_new.md),
[`ts_tree_query()`](https://r-lib.github.io/tsitter/reference/ts_tree_query.md),
[`ts_tree_select()`](https://r-lib.github.io/tsitter/reference/ts_tree_select.md),
[`ts_tree_sexpr()`](https://r-lib.github.io/tsitter/reference/ts_tree_sexpr.md),
[`ts_tree_unserialize()`](https://r-lib.github.io/tsitter/reference/ts_tree_unserialize.md),
[`ts_tree_update()`](https://r-lib.github.io/tsitter/reference/ts_tree_update.md),
[`ts_tree_write()`](https://r-lib.github.io/tsitter/reference/ts_tree_write.md)

## Examples

``` r
# Create a parse tree with tsjsonc -------------------------------------
tree <- tsjsonc::ts_parse_jsonc('{ "a": true, "b": [1, 2, 3] }')

ts_tree_insert(ts_tree_select(tree, "b"), 4, at = Inf)
#> # jsonc (6 lines)
#> 1 | { "a": true, "b": [
#> 2 |     1,
#> 3 |     2,
#> 4 |     3,
#> 5 |     4
#> 6 | ] }

# Create a parse tree with tstoml --------------------------------------
tree <- tstoml::ts_parse_toml(r"(
  [servers]
  alpha = { ip = "127.0.0.1", dc = "eqdc10" }
  beta = { ip = "127.0.0.2", dc = "eqdc20" }
)")

ts_tree_insert(
  ts_tree_select(tree, "servers", TRUE),
  key = "active",
  TRUE
)
#> # toml (3 lines)
#> 1 | [servers]
#> 2 |   alpha = { ip = "127.0.0.1", dc = "eqdc10", active = true }
#> 3 |   beta = { ip = "127.0.0.2", dc = "eqdc20", active = true }
```
