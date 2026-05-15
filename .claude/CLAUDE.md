## R package development

### Key commands

```R
# To run code
uncovr::reload(); code

# To run all tests
uncovr::test()

# To run all tests for files starting with {name}
uncovr::test('^{name}')

# To run all tests for R/{name}.R
uncovr::test_active('R/{name}.R')

# To redocument the package
uncovr::document()

# To check pkgdown documentation
pkgdown::check_pkgdown()

# To check the package with R CMD check
withr::with_envvar(
  c("NOT_CRAN" = "true"),
  rcmdcheck::rcmdcheck(args = c("--no-manual", "--as-cran"))
)
```

You have two options to run R code:

* `Rscript --no-environ  -e "code"`.

  Without `--no-environ`, every R call fails with `"Fatal error: cannot create 'R_TempDir'"` because the sandbox blocks reads of `~/.Renviron`, which R reads during startup before creating `tempdir()`.

* If the mcp-repl tool is available, you can use it instead. Note that its default sandbox blocks network requests.

Other commands:

```
# To format code
air format .
```

### Coding

* Always run `air format .` after generating code
* Don't use the base pipe operator (`|>`).
* Don't use `\() ...` anonymous functions. Use `function() {...}`

### Testing

- Tests for `R/{name}.R` go in `tests/testthat/test-{name}.R`.
- All new code should have an accompanying test.
- If there are existing tests, place new tests next to similar existing tests.
- Strive to keep your tests minimal with few comments.
- Never put code in a `test-{name}.R` file outside of a `test_that()` block. Instead, use `tests/testthat/helper.R` or `tests/testthat/helper-{name}.R`.
- Avoid `expect_true()` and `expect_false()` in favour of a specific expectation which will give a better failure message. A few expectations in newer releases that you might not know about are `expect_all_true()`, `expect_all_equal()`, and `expect_r6_class()`.
- When testing errors and warnings, don't use `expect_error()` or `expect_warning()`. Instead, use `expect_snapshot(error = TRUE)` for errors and `expect_snapshot()` for warnings because these allow the user to review the full text of the output.

### Documentation

- Every user-facing function should be exported and have roxygen2 documentation.
- Wrap roxygen comments at 80 characters.
- Whenever you add a new (non-internal) documentation topic, also add the topic to `_pkgdown.yml`.
- Use `pkgdown::check_pkgdown()` to check that all topics are included in the reference index.

### `NEWS.md`

- Every user-facing change should be given a bullet in `NEWS.md`.
- Changes that shouldn't get a bullet:
    - Small documentation changes.
    - Internal refactorings.
    - Fixes to bugs introduced in the current dev version.
- Each bullet should briefly describe the change to the end user and mention the related issue in parentheses.
- A bullet can consist of multiple sentences but should not contain any new lines (i.e. DO NOT line wrap).
- If the change is related to a function, put the name of the function early in the bullet.
- Order bullets alphabetically by function name. Put all bullets that don't mention function names at the beginning.

### Writing

- Use sentence case for headings.
- Use US English.

### Proofreading

If the user asks you to proofread a file, act as an expert proofreader and editor with a deep understanding of clear, engaging, and well-structured writing.

Work paragraph by paragraph, always starting by making a TODO list that includes individual items for each top-level heading.

Fix spelling, grammar, and other minor problems without asking the user. Label any unclear, confusing, or ambiguous sentences with a FIXME comment.

Only report what you have changed.
