#| title: 
# ---
The formatting of the rest of the document is left as is.

\eval{tsitter:::doc_tabs("ts_tree_delete_details_formatting")}

If the tree does not have a selection, the tree corresponding to the
empty document is returned, i.e. the whole content is deleted.

\eval{tsitter:::doc_tabs("ts_tree_delete_details_no_selection")}

If the tree has a selection, but it is the empty selection, then
the tree is returned unchanged.

\eval{tsitter:::doc_tabs("ts_tree_delete_details_empty_selection")}

For parsers that support comments, deleting elements that include
comments typically delete the comments as well. Other comments are
kept as is. See details in the manual of the specific parser.

\eval{tsitter:::doc_tabs("ts_tree_delete_details_comments")}
