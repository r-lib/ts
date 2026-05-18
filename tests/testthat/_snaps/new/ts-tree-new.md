# ts_tree_new parse error

    Code
      ts_tree_new(tsjsonc::ts_language_jsonc(), text = "{\"a\": 1, \"b\": [1,2,3")
    Condition
      Error in `ts_tree_new.ts_language()`:
      ! JSONC parse error `<text>`:1:21
      1| {"a": 1, "b": [1,2,3
                             ^

