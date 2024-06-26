update-tree-sitter:
    -rm languages/roc/*.scm
    cd ../tree-sitter-roc && git pullr
    cp -v ../tree-sitter-roc/queries/*.scm languages/roc

clean:
    -rm -rf grammars
    -rm -f extension.wasm

update-extension:
    cd ../zed-roc-extensions && git pullr && cd extensions/roc && git pullr
