update-tree-sitter:
    -rm languages/roc/*.scm
    cp ../tree-sitter-roc/queries/*.scm languages/roc

clean:
    -rm -rf grammars
    -rm -f extension.wasm
