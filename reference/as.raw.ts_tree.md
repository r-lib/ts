# Raw bytes of a document of a tree-sitter tree

Raw bytes of a document of a tree-sitter tree

## Usage

``` r
# S3 method for class 'ts_tree'
as.raw(x)
```

## Arguments

- x:

  A `ts_tree` object.

## Value

A raw vector containing the bytes of the document of the tree.

## See also

[`as.character.ts_tree()`](https://r-lib.github.io/tsitter/reference/as.character.ts_tree.md)
to get the document as a character scalar.

## Examples

``` r
# Create a parse tree with tsjsonc -------------------------------------
tree <- tsjsonc::ts_parse_jsonc('{"foo": 42, "bar": [1, 2, 3]}')

tree
#> # jsonc (1 line)
#> 1 | {"foo": 42, "bar": [1, 2, 3]}
as.raw(tree)
#>  [1] 7b 22 66 6f 6f 22 3a 20 34 32 2c 20 22 62 61 72 22 3a 20 5b 31 2c
#> [23] 20 32 2c 20 33 5d 7d
```
