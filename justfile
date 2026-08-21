grammar_repository := `sed -n '/^\[grammars\.roc\]/,/^\[/s/^repository = "\(.*\)"/\1/p' extension.toml | head -n 1`
grammar_commit := `sed -n '/^\[grammars\.roc\]/,/^\[/s/^commit = "\(.*\)"/\1/p' extension.toml | head -n 1`

check:
    cargo fmt -- --check
    cargo clippy --all-targets -- -D warnings
    cargo test
    cargo build --target wasm32-wasip2

# Sync the generated highlight query from the tree-sitter-roc commit in extension.toml.
# Other editor queries are maintained here because Zed's behavior differs.
sync-queries:
    mkdir -p grammars
    if [ ! -d grammars/roc/.git ]; then git clone {{grammar_repository}} grammars/roc; fi
    cd grammars/roc && git remote set-url origin {{grammar_repository}}
    cd grammars/roc && git fetch origin && git checkout {{grammar_commit}}
    cp -v grammars/roc/queries-generated/zed/queries/highlights.scm languages/roc/
    just check-highlight-captures
    rm -f grammars/roc.wasm

# Reject highlight captures that Zed themes do not support.
check-highlight-captures:
    scripts/check-highlight-captures.sh

# Update grammar to a specific commit and sync queries
update-grammar COMMIT:
    mkdir -p grammars
    if [ ! -d grammars/roc/.git ]; then git clone {{grammar_repository}} grammars/roc; fi
    cd grammars/roc && git remote set-url origin {{grammar_repository}}
    cd grammars/roc && git fetch origin && git checkout {{COMMIT}}
    cp -v grammars/roc/queries-generated/zed/queries/highlights.scm languages/roc/
    just check-highlight-captures
    rm -f grammars/roc.wasm
    @echo "Done. Click 'Rebuild' in Zed to recompile the grammar."

# Clean build artifacts
clean:
    rm -f grammars/roc.wasm
    rm -f extension.wasm
