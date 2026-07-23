# Select elements of a tree-sitter tree

This function is the heart of ts. To edit a tree-sitter tree, you first
need to select the parts you want to delete or update.

## Usage

``` r
ts_tree_select(tree, ..., refine = FALSE)
```

## Arguments

- tree:

  A `ts_tree` object as returned by
  [`ts_tree_new()`](https://r-lib.github.io/tsitter/reference/ts_tree_new.md).

- ...:

  Selection expressions, see details.

- refine:

  Logical, whether to refine the current selection or start a new
  selection.

## Value

A `ts_tree` object with the selected parts.

## Details

The selection process is iterative. Selection expressions (selectors)
are applied one by one, and each selector selects nodes from the
currently selected nodes. For each selector, it is applied individually
to each currently selected node, and the results are concatenated.

The selection process starts from the root of the DOM tree, the document
node (see
[`ts_tree_dom()`](https://r-lib.github.io/tsitter/reference/ts_tree_dom.md)),
unless `refine = TRUE` is set, in which case it starts from the current
selection.

See the various types of selection expressions below.

### Selectors

#### All elements: `TRUE`

Selects all child nodes of the current nodes.

#### Specific keys: character vector

Selects child nodes with the given names from nodes with named children.
If a node has no named children, it selects nothing from that node.

#### By position: integer vector

Selects child nodes by position. Positive indices count from the start,
negative indices count from the end. Zero indices are not allowed.

#### Matching keys: regular expression

A character scalar named `regex` can be used to select child nodes whose
names match the given regular expression, from nodes with named
children. If a node has no named children, it selects nothing from that
node.

#### Tree sitter query matches

A character scalar named `query` can be used to select nodes matching a
tree-sitter query. See
[`ts_tree_query()`](https://r-lib.github.io/tsitter/reference/ts_tree_query.md)
for details on tree-sitter queries.

Instead of a character scalar this can also be a two-element list, where
the first element is the query string and the second element is a
character vector of capture names to select. In this case only nodes
matching the given capture names will be selected.

#### Explicit node ids

You can use `I(c(...))` to select nodes by their ids directly. This is
for advanced use cases only.

### Refining selections

If the `refine` argument of `ts_tree_select()` is `TRUE`, then the
selection starts from the already selected elements (all of them
simultanously), instead of starting from the document element.

### The `ts_tree_select<-()` replacement function

The
[`ts_tree_select<-()`](https://r-lib.github.io/tsitter/reference/select-set.md)
replacement function works similarly to the combination of
`ts_tree_select()` and
[`ts_tree_update()`](https://r-lib.github.io/tsitter/reference/ts_tree_update.md),
but it might be more readable.

### The `[[` and `[[<-` operators

The `[[` operator works similarly to the combination of
`ts_tree_select()` and
[`ts_tree_unserialize()`](https://r-lib.github.io/tsitter/reference/ts_tree_unserialize.md),
but it might be more readable.

The `[[<-` operator works similarly to the combination of
`ts_tree_select()` and
[`ts_tree_update()`](https://r-lib.github.io/tsitter/reference/ts_tree_update.md),
(and also to the replacement function
[`ts_tree_select<-()`](https://r-lib.github.io/tsitter/reference/select-set.md)),
but it might be more readable.

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
[`ts_tree_sexpr()`](https://r-lib.github.io/tsitter/reference/ts_tree_sexpr.md),
[`ts_tree_unserialize()`](https://r-lib.github.io/tsitter/reference/ts_tree_unserialize.md),
[`ts_tree_update()`](https://r-lib.github.io/tsitter/reference/ts_tree_update.md),
[`ts_tree_write()`](https://r-lib.github.io/tsitter/reference/ts_tree_write.md)

## Examples

``` r
# ----------------------------------------------------------------------
# Create a JSONC tree, needs the tsjsonc package
json <- ts_tree_new(
  tsjsonc::ts_language_jsonc(),
  text = '{ "a": 1, "b": 2, "c": { "d": 3, "e": 4 } }'
)

ts_tree_select(json, "c", "d")
#> # jsonc (1 line, 1 selected element)
#> > 1 | { "a": 1, "b": 2, "c": { "d": 3, "e": 4 } }

# ----------------------------------------------------------------------
# Create a TOML tree, needs the tstoml package
toml <- ts_tree_new(
  tstoml::ts_language_toml(),
  text = tstoml::toml_example_text()
)

ts_tree_select(toml, "servers", TRUE, "ip")
#> # toml (23 lines, 2 selected elements)
#>   ...   
#>   15  | [servers]
#>   16  | 
#>   17  | [servers.alpha]
#> > 18  | ip = "10.0.0.1"
#>   19  | role = "frontend"
#>   20  | 
#>   21  | [servers.beta]
#> > 22  | ip = "10.0.0.2"
#>   23  | role = "backend"
```
