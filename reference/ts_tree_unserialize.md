# Unserialize selected elements of a tree-sitter tree

Unserialize the selected elements of a `ts_tree` object, i.e. convert
them to R objects.

## Usage

``` r
ts_tree_unserialize(tree)
```

## Arguments

- tree:

  A `ts_tree` object.

## Value

List of R objects, with one entry for each selected element.

## Details

If no elements are selected in the tree, then the whole document is
unserialized.

If the tree has an empty selection, then an empty list is returned.

### The `[[` operator

The `[[` operator works similarly to the combination of
[`ts_tree_select()`](https://r-lib.github.io/tsitter/reference/ts_tree_select.md)
and `ts_tree_unserialize()`, but it might be more readable.

For the details on how the selected elements are mapped to R objects,
see the documentation of the methods in the parser packages. The methods
in the installed parser packages are linked below.

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
[`ts_tree_update()`](https://r-lib.github.io/tsitter/reference/ts_tree_update.md),
[`ts_tree_write()`](https://r-lib.github.io/tsitter/reference/ts_tree_write.md)

Other serialization functions:
[`[[.ts_tree()`](https://r-lib.github.io/tsitter/reference/double-bracket-ts-tree.md)

## Examples

``` r
# Create a parse tree with tsjsonc -------------------------------------
tree <- tsjsonc::ts_parse_jsonc('{"a": 13, "b": [1, 2, 3], "c": "x"}')

tree
#> # jsonc (1 line)
#> 1 | {"a": 13, "b": [1, 2, 3], "c": "x"}

ts_tree_unserialize(ts_tree_select(tree, c("b", "c")))
#> [[1]]
#> [[1]][[1]]
#> [1] 1
#> 
#> [[1]][[2]]
#> [1] 2
#> 
#> [[1]][[3]]
#> [1] 3
#> 
#> 
#> [[2]]
#> [1] "x"
#> 

ts_tree_unserialize(ts_tree_select(tree, "b"))
#> [[1]]
#> [[1]][[1]]
#> [1] 1
#> 
#> [[1]][[2]]
#> [1] 2
#> 
#> [[1]][[3]]
#> [1] 3
#> 
#> 
```
