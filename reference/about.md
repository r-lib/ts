# About tsitter

tsitter is a common interface to
[tree-sitter](https://tree-sitter.github.io/tree-sitter/) parsers,
implemented in other R packages. It has a common API to

- query,

- edit,

- format, and

- unserialize

tree-sitter parse trees.

## Value

Not applicable.

## Details

In this document I show examples with the `tsjsonc` package.

### Create a tree-sitter tree

Create a ts_tree (ts_tree_jsonc) object from a string:

    txt <- r"(
    // this is a comment
    {
      "a": {
        "a1": [1, 2, 3],
        // comment
        "a2": "string"
      },
      "b": [
        {
          "b11": true,
          "b12": false
        },
        {
          "b21": false,
          "b22": false
        }
      ]
    }
    )"

    json <- tsjsonc::ts_parse_jsonc(txt)


    #>

Pretty print a ts_tree object:

    json


    #> # jsonc (19 lines)
    #>  1 | 
    #>  2 | // this is a comment
    #>  3 | {
    #>  4 |   "a": {
    #>  5 |     "a1": [1, 2, 3],
    #>  6 |     // comment
    #>  7 |     "a2": "string"
    #>  8 |   },
    #>  9 |   "b": [
    #> 10 |     {
    #> ℹ 9 more lines
    #> ℹ Use `print(n = ...)` to see more lines

### Select nodes of a tree

Selecting nodes is the basis of editing and querying tree-sitter trees.

Select element by objects key:

    ts_tree_select(json, "a")


    #> Error in ts_tree_select(json, "a") :
    #>   could not find function "ts_tree_select"

Select element inside element:

    ts_tree_select(json, "a", "a1")


    #> Error in ts_tree_select(json, "a", "a1") :
    #>   could not find function "ts_tree_select"

Select element(s) of an array:

    ts_tree_select(json, "a", "a1", 1:2)


    #> Error in ts_tree_select(json, "a", "a1", 1:2) :
    #>   could not find function "ts_tree_select"

Select multiple keys from an object:

    ts_tree_select(json, "a", c("a1", "a2"))


    #> Error in ts_tree_select(json, "a", c("a1", "a2")) :
    #>   could not find function "ts_tree_select"

Select nodes that match a tree-sitter query:

    json |> ts_tree_select(query = "((pair value: (false) @val))")


    #> Error in ts_tree_select(json, query = "((pair value: (false) @val))") :
    #>   could not find function "ts_tree_select"

### Delete elements

Delete selected elements:

    ts_tree_select(json, "a", "a1") |> ts_tree_delete()


    #> Error in ts_tree_delete(ts_tree_select(json, "a", "a1")) :
    #>   could not find function "ts_tree_delete"

### Insert elements

Insert element into an array:

    ts_tree_select(json, "a", "a1") |> ts_tree_insert(at = 2, "new")


    #> Error in ts_tree_insert(ts_tree_select(json, "a", "a1"), at = 2, "new") :
    #>   could not find function "ts_tree_insert"

Inserting into an array reformats the array.

Insert element into an object, at the specified key:

    ts_tree_select(json, "a") |>
      ts_tree_insert(key = "a0", at = 0, list("new", "element"))


    #> Error in ts_tree_insert(ts_tree_select(json, "a"), key = "a0", at = 0,  :
    #>   could not find function "ts_tree_insert"

### Update elements

Update existing element:

    ts_tree_select(json, "a", c("a1", "a2")) |> ts_tree_update("new value")


    #>
    #>   could not find function "ts_tree_update"

Inserts the element if some parents are missing:

    json <- ts_parse_jsonc(text = "{ \"a\": { \"b\": true } }")
    json


    #> Error in ts_parse_jsonc(text = "{ \"a\": { \"b\": true } }") :
    #>   could not find function "ts_parse_jsonc"
    #> # jsonc (19 lines)
    #>  1 | 
    #>  2 | // this is a comment
    #>  3 | {
    #>  4 |   "a": {
    #>  5 |     "a1": [1, 2, 3],
    #>  6 |     // comment
    #>  7 |     "a2": "string"
    #>  8 |   },
    #>  9 |   "b": [
    #> 10 |     {
    #> ℹ 9 more lines
    #> ℹ Use `print(n = ...)` to see more lines

    ts_tree_select(json, "a", "x", "y") |> ts_tree_update(list(1,2,3))


    #> Error in ts_tree_update(ts_tree_select(json, "a", "x", "y"), list(1, 2,  :
    #>   could not find function "ts_tree_update"

### Write out a document

Use [`stdout()`](https://rdrr.io/r/base/showConnections.html) to write
it to the screen instread of a file:

    json |> ts_tree_write(stdout())


    #> Error in ts_tree_write(json, stdout()) :
    #>   could not find function "ts_tree_write"

### Formatting

Format the whole document:

    json |> ts_tree_format()


    #> Error in ts_tree_format(json) : could not find function "ts_tree_format"

Format part of the document:

    json |> ts_tree_select("a") |>
      ts_tree_format(options = list(format = "compact"))


    #> act")) :
    #>   could not find function "ts_tree_format"

### Unserializing

Unserialize a whole document:

    json |> ts_tree_unserialize()


    #> Error in ts_tree_unserialize(json) :
    #>   could not find function "ts_tree_unserialize"

Note that
[`ts_tree_unserialize()`](https://r-lib.github.io/tsitter/reference/ts_tree_unserialize.md)
always returns a list, the first element of the list is the unserialized
document.

Unserialize part(s) of the document:

    json |> ts_tree_select("b") |> ts_tree_unserialize()


    #> Error in ts_tree_unserialize(ts_tree_select(json, "b")) :
    #>   could not find function "ts_tree_unserialize"

Again,
[`ts_tree_unserialize()`](https://r-lib.github.io/tsitter/reference/ts_tree_unserialize.md)
returns a list, with one element for each selected node.

### Exploring a tree-sitter tree

It is often useful to explore the structure of a (JSONC) tree-sitter
tree, to help writing the right selection or tree-sitter queries.

Print the annotated syntax tree:

    ts_tree_ast(json)


    #> Error in ts_tree_ast(json) : could not find function "ts_tree_ast"

Print the document object model:

    ts_tree_dom(json)


    #> Error in ts_tree_dom(json) : could not find function "ts_tree_dom"

Print the structural summary of a tree:

    ts_tree_sexpr(json)


    #> Error in ts_tree_sexpr(json) : could not find function "ts_tree_sexpr"
    #>
    #>
    #>
    #>
    #>
    #>

## Examples

``` r
# See above please.
```
