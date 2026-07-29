in_check <- basename(dirname(getwd())) == "00_pkg_src"
packaged <- "Packaged" %in% colnames(read.dcf("DESCRIPTION"))

sub_examples <- function(fun) {
  for (rd in Sys.glob("man/*.Rd")) {
    old <- readLines(rd, warn = FALSE)
    if (!any(grepl("\\%>\\%", old, fixed = TRUE))) {
      next
    }
    new <- fun(old)
    if (!identical(new, old)) {
      writeLines(new, rd)
    }
  }
}

if (getRversion() < "4.1") {
  # No base pipe on this R, so don't run the examples at all.
  dir.create("man/macros", showWarnings = FALSE, recursive = TRUE)
  cat(
    paste(
      "\\renewcommand{\\examples}{\\section{Examples}{",
      "These examples are designed to work in R >= 4.1 so that we can take",
      "advantage of modern syntax like the base pipe (\\verb{|>}) and the ",
      "function shorthand (\\verb{\\(x) x + 1}). They might not work on the ",
      "version of R that you're using.",
      "\\preformatted{#1}}}",
      collapse = ""
    ),
    file = "man/macros/examples.Rd"
  )
} else if (in_check) {
  cat("Binding magrittr's %>% in the examples, this is an R CMD check\n")
  sub_examples(function(lines) {
    at <- grep("^\\\\examples\\{$", lines)
    if (!length(at)) {
      return(lines)
    }
    append(lines, "`\\%>\\%` <- magrittr::`\\%>\\%`", after = at[1])
  })
} else if (!packaged && Sys.getenv("IN_PKGDOWN") == "") {
  cat("*** Not substituting the base pipe in man/*.Rd, this is a source tree\n")
} else {
  cat("*** Substituting the base pipe in man/*.Rd\n")
  sub_examples(function(lines) gsub("\\%>\\%", "|>", lines, fixed = TRUE))
}
