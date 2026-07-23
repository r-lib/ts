# Delete selected elements from a tree-sitter tree

Use
[`ts_tree_select()`](https://r-lib.github.io/tsitter/reference/ts_tree_select.md)
to select the elements to be deleted, and then call `ts_tree_delete()`
to remove them from the tree.

## Usage

``` r
ts_tree_delete(tree, ...)
```

## Arguments

- tree:

  A `ts_tree` object.

- ...:

  Extra arguments for methods.

## Value

The modified `ts_tree` object with the selected elements removed.

## Details

The formatting of the rest of the document is left as is.

If the tree does not have a selection, the tree corresponding to the
empty document is returned, i.e. the whole content is deleted.

If the tree has a selection, but it is the empty selection, then the
tree is returned unchanged.

For parsers that support comments, deleting elements that include
comments typically delete the comments as well. Other comments are kept
as is. See details in the manual of the specific parser.

## See also

Other ts_tree generics:
[`[[.ts_tree()`](https://r-lib.github.io/tsitter/reference/double-bracket-ts-tree.md),
[`[[<-.ts_tree()`](https://r-lib.github.io/tsitter/reference/double-bracket-set-ts-tree.md),
[`format.ts_tree()`](https://r-lib.github.io/tsitter/reference/format.ts_tree.md),
[`print.ts_tree()`](https://r-lib.github.io/tsitter/reference/print.ts_tree.md),
[`select-set`](https://r-lib.github.io/tsitter/reference/select-set.md),
[`ts_tree_ast()`](https://r-lib.github.io/tsitter/reference/ts_tree_ast.md),
[`ts_tree_dom()`](https://r-lib.github.io/tsitter/reference/ts_tree_dom.md),
[`ts_tree_format()`](https://r-lib.github.io/tsitter/reference/ts_tree_format.md),
[`ts_tree_insert()`](https://r-lib.github.io/tsitter/reference/ts_tree_insert.md),
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
tree <- tsjsonc::ts_parse_jsonc(
  "{ \"a\": //comment\ntrue, \"b\": [1, 2, 3] }"
)

tree
#> # jsonc (2 lines)
#> 1 | { "a": //comment
#> 2 | true, "b": [1, 2, 3] }

ts_tree_select(tree, "a")
#> # jsonc (2 lines, 1 selected element)
#> > 1 | { "a": //comment
#>   2 | true, "b": [1, 2, 3] }

ts_tree_delete(ts_tree_select(tree, "a"))
#> # jsonc (1 line)
#> 1 | { "b": [1, 2, 3] }
# Create a parse tree with tstoml --------------------------------------
tree <- tstoml::ts_parse_toml(r"(
  [servers]
  alpha = { ip = "127.0.0.1", dc = "eqdc10" }
  beta = { ip = "127.0.0.2", dc = "eqdc20" }
)")

tree
#> # toml (4 lines)
#> 1 | 
#> 2 |   [servers]
#> 3 |   alpha = { ip = "127.0.0.1", dc = "eqdc10" }
#> 4 |   beta = { ip = "127.0.0.2", dc = "eqdc20" }

ts_tree_select(tree, "servers", TRUE, "dc")
#> # toml (4 lines, 2 selected elements)
#>   1 | 
#>   2 |   [servers]
#> > 3 |   alpha = { ip = "127.0.0.1", dc = "eqdc10" }
#> > 4 |   beta = { ip = "127.0.0.2", dc = "eqdc20" }
ts_tree_delete(ts_tree_select(tree, "servers", TRUE, "dc"))
#> # toml (3 lines)
#> 1 | [servers]
#> 2 |   alpha = { ip = "127.0.0.1" }
#> 3 |   beta = { ip = "127.0.0.2" }
```
