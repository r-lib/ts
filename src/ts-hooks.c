// Failure handlers for the vendored tree-sitter library. tree-sitter aborts
// the process and writes to stderr on allocation failures and failed
// assertions, which an R package must not do, so its sources are patched to
// call these functions instead. Both throw an R error and do not return.
// See src/tree-sitter/lib/src/alloc.c and ts_assert.h.

#define R_NO_REMAP
#include <R.h>

#include <stddef.h>

// # nocov start

void ts_alloc_failed(size_t size) {
  Rf_error("tree-sitter failed to allocate %.0f bytes", (double) size);
}

void ts_assert_failed(const char *expr, const char *file, int line) {
  Rf_error(
    "tree-sitter internal error: assertion `%s` failed at %s:%d",
    expr,
    file,
    line
  );
}

// # nocov end
