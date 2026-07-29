#ifndef TREE_SITTER_ASSERT_H_
#define TREE_SITTER_ASSERT_H_

#ifdef NDEBUG
#define ts_assert(e) ((void)(e))
#else
// tsitter patch: assert() from libc calls abort() and writes to stderr, which
// an R package must not do, so failed assertions are reported via
// ts_assert_failed(), see src/ts-hooks.c. It throws an R error and does not
// return.
extern void ts_assert_failed(const char *expr, const char *file, int line);
#define ts_assert(e) \
  ((e) ? (void) 0 : ts_assert_failed(#e, __FILE__, __LINE__))
#endif

#endif // TREE_SITTER_ASSERT_H_
