# Sync query files from tree-sitter-roc to languages/roc
sync-queries:
    cp -v grammars/roc/queries/*.scm languages/roc/

# Update grammar to a specific commit and sync queries
update-grammar COMMIT:
    cd grammars/roc && git fetch origin && git checkout {{COMMIT}}
    just sync-queries
    rm -f grammars/roc.wasm
    @echo "Done. Click 'Rebuild' in Zed to recompile the grammar."

# Clean build artifacts
clean:
    rm -f grammars/roc.wasm
    rm -f extension.wasm
