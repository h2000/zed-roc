grammar_commit := `sed -n 's/^commit = "\(.*\)"/\1/p' extension.toml`

check:
    cargo fmt -- --check
    cargo clippy --all-targets -- -D warnings
    cargo test
    cargo build --target wasm32-wasip2

# Sync query files from the tree-sitter-roc commit in extension.toml.
sync-queries:
    mkdir -p grammars
    if [ ! -d grammars/roc/.git ]; then git clone https://github.com/faldor20/tree-sitter-roc.git grammars/roc; fi
    cd grammars/roc && git fetch origin && git checkout {{grammar_commit}}
    cp -v grammars/roc/queries/*.scm languages/roc/

# Update grammar to a specific commit and sync queries
update-grammar COMMIT:
    mkdir -p grammars
    if [ ! -d grammars/roc/.git ]; then git clone https://github.com/faldor20/tree-sitter-roc.git grammars/roc; fi
    cd grammars/roc && git fetch origin && git checkout {{COMMIT}}
    cp -v grammars/roc/queries/*.scm languages/roc/
    rm -f grammars/roc.wasm
    @echo "Done. Click 'Rebuild' in Zed to recompile the grammar."

# Clean build artifacts
clean:
    rm -f grammars/roc.wasm
    rm -f extension.wasm
