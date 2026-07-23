# Format the selected elements of a tree sitter tree for printing

(Re)format the selected elements of the document represented by a
tree-sitter tree, if the tree-sitter parser supports formatting.

## Usage

``` r
ts_tree_format(tree, options, ...)
```

## Arguments

- tree:

  A `ts_tree` object.

- options:

  A list of options for the formatting.

  See details in the manual of the specific parser.

- ...:

  Extra arguments for methods.

## Value

A `ts_tree` object representing the reformatted document.

## Details

If `tree` does not have a selection, then the whole document is
formatted.

If `tree` has an empty selection, then it is returned unchanged.

Some parsers support options to customize the formatting. See details in
the manual of the specific parser.

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
tree <- tsjsonc::ts_parse_jsonc('{ "a":true, "b": [1,2,3] }')
tree
#> # jsonc (1 line)
#> 1 | { "a":true, "b": [1,2,3] }

# Format whole document
ts_tree_format(tree)
#> # jsonc (8 lines)
#> 1 | {
#> 2 |     "a": true,
#> 3 |     "b": [
#> 4 |         1,
#> 5 |         2,
#> 6 |         3
#> 7 |     ]
#> 8 | }

# Format each top element under the document node in one line
ts_tree_format(
  ts_tree_select(ts_tree_format(tree), TRUE),
  options = list(format = "oneline")
)
#> # jsonc (4 lines)
#> 1 | {
#> 2 |     "a": true,
#> 3 |     "b": [ 1, 2, 3 ]
#> 4 | }

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

ts_tree_format(tree)
#> # toml (3 lines)
#> 1 | [servers]
#> 2 | alpha = { ip = "127.0.0.1", dc = "eqdc10" }
#> 3 | beta = { ip = "127.0.0.2", dc = "eqdc20" }
```
