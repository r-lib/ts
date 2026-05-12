# The document of a tree-sitter tree as a character scalar

The document of a tree-sitter tree as a character scalar

## Usage

``` r
# S3 method for class 'ts_tree'
as.character(x, ...)
```

## Arguments

- x:

  A `ts_tree` object.

- ...:

  Ignored.

## Value

A character scalar containing the document of the tree.

## See also

[`as.raw.ts_tree()`](https://r-lib.github.io/ts/reference/as.raw.ts_tree.md)
to get the document as a raw vector.

## Examples

``` r
# Create a parse tree with tsjsonc -------------------------------------
tree <- tsjsonc::ts_parse_jsonc('{"foo": 42, "bar": [1, 2, 3]}')

tree
#> # jsonc (1 line)
#> 1 | {"foo": 42, "bar": [1, 2, 3]}
as.character(tree)
#> [1] "{\"foo\": 42, \"bar\": [1, 2, 3]}"
```
