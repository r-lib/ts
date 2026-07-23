# Replace selected elements with a new element in a tree-sitter tree

Replace all selected elements with a new element.

## Usage

``` r
ts_tree_update(tree, new, options, ...)
```

## Arguments

- tree:

  A `ts_tree` object.

- new:

  The new element to replace the selected elements with.

  The type of `new` depends on the parser and the method that implements
  the insertion. See details in the manual of the specific parser.

  See details in the manual of the specific parser.

- options:

  A list of options for the update.

- ...:

  Extra arguments for methods.

## Value

The modified `ts_tree` object with the selected elements replaced by the
new element.

## Details

If the tree does not have a selection, the new element replaces the
whole document.

If the tree has an empty selection, the new element is inserted at the
position of where the selected elements would be.

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
[`ts_tree_insert()`](https://r-lib.github.io/tsitter/reference/ts_tree_insert.md),
[`ts_tree_new()`](https://r-lib.github.io/tsitter/reference/ts_tree_new.md),
[`ts_tree_query()`](https://r-lib.github.io/tsitter/reference/ts_tree_query.md),
[`ts_tree_select()`](https://r-lib.github.io/tsitter/reference/ts_tree_select.md),
[`ts_tree_sexpr()`](https://r-lib.github.io/tsitter/reference/ts_tree_sexpr.md),
[`ts_tree_unserialize()`](https://r-lib.github.io/tsitter/reference/ts_tree_unserialize.md),
[`ts_tree_write()`](https://r-lib.github.io/tsitter/reference/ts_tree_write.md)

## Examples

``` r
# Create a parse tree with tsjsonc -------------------------------------
tree <- tsjsonc::ts_parse_jsonc(r"(
  {
    "name": "example",
    "version": "1.0.0",
    "dependencies": {
      "tsjsonc": "^0.1.0"
    }
  }
)")

ts_tree_update(ts_tree_select(tree, "version"), "2.0.0")
#> # jsonc (8 lines)
#> 1 | 
#> 2 |   {
#> 3 |     "name": "example",
#> 4 |     "version": "2.0.0",
#> 5 |     "dependencies": {
#> 6 |       "tsjsonc": "^0.1.0"
#> 7 |     }
#> 8 |   }
# Create a parse tree with tstoml --------------------------------------
tree <- tstoml::ts_parse_toml(r"(
  [package]
  name = "example"
  version = "1.0.0"
  depdendencies = { tstoml = "0.1.0" }
)")

ts_tree_update(ts_tree_select(tree, "package", "version"), "2.0.0")
#> # toml (4 lines)
#> 1 | [package]
#> 2 |   name = "example"
#> 3 |   version = "2.0.0"
#> 4 |   depdendencies = { tstoml = "0.1.0" }
```
