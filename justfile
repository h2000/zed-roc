grammar_repository := `sed -n '/^\[grammars\.roc\]/,/^\[/s/^repository = "\(.*\)"/\1/p' extension.toml | head -n 1`
grammar_commit := `sed -n '/^\[grammars\.roc\]/,/^\[/s/^commit = "\(.*\)"/\1/p' extension.toml | head -n 1`

check:
    cargo fmt -- --check
    cargo clippy --all-targets -- -D warnings
    cargo test
    cargo build --target wasm32-wasip2

# Sync query files from the tree-sitter-roc commit in extension.toml.
sync-queries:
    mkdir -p grammars
    if [ ! -d grammars/roc/.git ]; then git clone {{grammar_repository}} grammars/roc; fi
    cd grammars/roc && git remote set-url origin {{grammar_repository}}
    cd grammars/roc && git fetch origin && git checkout {{grammar_commit}}
    cp -v grammars/roc/queries/*.scm languages/roc/

# Update grammar to a specific commit and sync queries
update-grammar COMMIT:
    mkdir -p grammars
    if [ ! -d grammars/roc/.git ]; then git clone {{grammar_repository}} grammars/roc; fi
    cd grammars/roc && git remote set-url origin {{grammar_repository}}
    cd grammars/roc && git fetch origin && git checkout {{COMMIT}}
    cp -v grammars/roc/queries/*.scm languages/roc/
    rm -f grammars/roc.wasm
    @echo "Done. Click 'Rebuild' in Zed to recompile the grammar."

# Clean build artifacts
clean:
    rm -f grammars/roc.wasm
    rm -f extension.wasm
