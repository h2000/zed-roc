# Roc lang support for Zed

An extension for Zed that adds Roc language support:

- syntax highlighting through treesitter and
- type tooltips, error marker, completion ... through the roc language server

## Prerequisites

- Install Roc from the [roc-lang](https://roc-lang.org) website
- Ensure the `roc` binary is in your PATH
- Install Zed from the [Zed](https://zed.dev) website

## ROC

- Website: [roc-lang.org](https://roc-lang.org)
- Tree Sitter: [tree-sitter-roc](https://github.com/faldor20/tree-sitter-roc)
- Language Server: This extension uses the new experimental LSP integrated into the `roc` CLI via `roc experimental-lsp`.

## Development

### Installing the Dev Extension

1. Open Zed's command palette (Cmd+Shift+P / Ctrl+Shift+P)
2. Run "zed: install dev extension"
3. Select this repository folder
4. Click "Rebuild" if prompted

**Note:** The version shown in Zed's Extensions panel may display the marketplace version (e.g., v0.0.6) even when the dev extension is active. This is a Zed caching behavior when the extension ID matches a marketplace extension.

### Verifying the Dev Extension is Running

Check Zed's logs (Command palette → "zed: open log file") and look for:
```
compiling Rust extension /path/to/your/zed-roc
```

If the path points to your local repository (not `~/Library/Application Support/Zed/extensions/installed/roc`), the dev extension is active.

### Key Files

- `extension.toml` - Extension manifest (id, version, grammar source, language config)
- `languages/roc/config.toml` - Language configuration (file extensions, comments, brackets)
- `languages/roc/*.scm` - Tree-sitter queries (highlights, indents, etc.)
- `grammars/roc/` - Git clone of tree-sitter-roc (must match repository in extension.toml)

### Updating the Tree-sitter Grammar

The `grammars/roc/` directory must be a git clone of the repository specified in `extension.toml`. To update:

1. Update the commit hash in `extension.toml` under `[grammars.roc]`
2. Update the grammar submodule:
   ```sh
   cd grammars/roc
   git fetch origin
   git checkout <commit-hash>
   ```
3. Sync query files: `cp grammars/roc/queries/*.scm languages/roc/`
4. Delete cached wasm to force recompilation: `rm grammars/roc.wasm`
5. In Zed, click "Rebuild" on the extension

### Troubleshooting

**Extension not detecting .roc files:**
- Check Zed logs for errors (Command palette → "zed: open log file")
- Ensure `languages = ["languages/roc"]` is in `extension.toml`

**Conflict with marketplace version:**
- Uninstall the marketplace Roc extension first
- If uninstall doesn't work, quit Zed and manually edit the extensions index.json to remove "roc" entries
- Zed stores extensions in:
  - macOS: `~/Library/Application Support/Zed/extensions/`
  - Linux: `~/.local/share/zed/extensions/`

**Grammar compilation errors:**
- Ensure `grammars/roc/` is a git clone of the repository URL in `extension.toml`
- The git remote origin must match the repository URL exactly

### Useful Commands

```sh
# Sync query files from grammar to languages
cp grammars/roc/queries/*.scm languages/roc/

# Clean build artifacts
rm -f grammars/roc.wasm extension.wasm

# Check Zed logs (macOS)
tail -f ~/Library/Logs/Zed/Zed.log | grep -i roc
```

![Zed Example](https://github.com/h2000/zed-roc/assets/187650/1ec0cda3-3679-4223-bc5e-3272babde364)
