#| title: 
# ---
If no elements are selected in the tree, then the whole document is
unserialized.

\eval{tsitter:::doc_tabs("ts_tree_unserialize_details_no_selection")}

If the tree has an empty selection, then an empty list is returned.

\eval{tsitter:::doc_tabs("ts_tree_unserialize_details_empty_selection")}
\subsection{The \code{[[} operator}{

The \code{[[} operator works similarly to the combination of
\code{\link[tsitter:ts_tree_select]{ts_tree_select()}} and
\code{ts_tree_unserialize()}, but it might be more readable.

\eval{tsitter:::doc_tabs("ts_tree_select_brackets")}
}
