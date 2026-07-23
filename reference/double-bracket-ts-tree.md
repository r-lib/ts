# Unserialize parts of a tree-sitter tree

The `[[` operator works similarly to the combination of
[`ts_tree_select()`](https://r-lib.github.io/tsitter/reference/ts_tree_select.md)
and
[`ts_tree_unserialize()`](https://r-lib.github.io/tsitter/reference/ts_tree_unserialize.md),
but it might be more readable.

## Usage

``` r
# S3 method for class 'ts_tree'
x[[i, ...]]
```

## Arguments

- x:

  A `ts_tree` object.

- i:

  Selection expressions in a list, see details in
  [`ts_tree_select()`](https://r-lib.github.io/tsitter/reference/ts_tree_select.md).

- ...:

  Additional arguments, passed to
  [`ts_tree_select()`](https://r-lib.github.io/tsitter/reference/ts_tree_select.md).

## Value

List of R objects, with one entry for each selected element.

## Details

The following two expressions are equivalent:

    ts_tree_unserialize(ts_tree_select(tree, <selectors>))

and

    tree[[list(<selectors>)]]

### The `[[<-` replacement operator

The `[[<-` operator works similarly to the combination of
[`ts_tree_select()`](https://r-lib.github.io/tsitter/reference/ts_tree_select.md)
and
[`ts_tree_update()`](https://r-lib.github.io/tsitter/reference/ts_tree_update.md),
(and also to the replacement function
[`ts_tree_select<-()`](https://r-lib.github.io/tsitter/reference/select-set.md)),
but it might be more readable.

## See also

Other ts_tree generics:
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
[`ts_tree_update()`](https://r-lib.github.io/tsitter/reference/ts_tree_update.md),
[`ts_tree_write()`](https://r-lib.github.io/tsitter/reference/ts_tree_write.md)

Other serialization functions:
[`ts_tree_unserialize()`](https://r-lib.github.io/tsitter/reference/ts_tree_unserialize.md)

## Examples

``` r
# Create a parse tree with tsjsonc -------------------------------------
tree <- tsjsonc::ts_parse_jsonc('{"a": 13, "b": [1, 2, 3], "c": "x"}')

tree
#> # jsonc (1 line)
#> 1 | {"a": 13, "b": [1, 2, 3], "c": "x"}

tree[[list("a")]]
#> [[1]]
#> [1] 13
#> 

# Last two elements of "b"
tree[[list("b", -(1:2))]]
#> [[1]]
#> [1] 2
#> 
#> [[2]]
#> [1] 3
#> 
```
