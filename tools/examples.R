if (getRversion() >= "4.1") {
  # The \examples sections use magrittr's %>%, because `R CMD build` extracts
  # their code, infers the R version that its syntax needs, and would add an
  # R (>= 4.1.0) dependency to DESCRIPTION for the base pipe. Put the base
  # pipe back at installation time, on an R that has it.
  #
  # Only done for a tarball made by `R CMD build`, which is the one that adds
  # the `Packaged` field. Patching a source tree in place would rewrite the
  # tracked Rd files for good, and the next `R CMD build` would add the
  # R (>= 4.1.0) dependency after all.
  if (!"Packaged" %in% colnames(read.dcf("DESCRIPTION"))) {
    cat("Not substituting the base pipe in man/*.Rd, this is a source tree\n")
  } else {
    for (rd in Sys.glob("man/*.Rd")) {
      old <- readLines(rd, warn = FALSE)
      new <- gsub("\\%>\\%", "|>", old, fixed = TRUE)
      if (!identical(new, old)) {
        writeLines(new, rd)
      }
    }
  }
} else {
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
}
