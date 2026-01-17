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

```sh
~/Library/Application\ Support/Zed/extensions/installed/
less ~/Library/Logs/Zed/Zed.log
```

![Zed Example](https://github.com/h2000/zed-roc/assets/187650/1ec0cda3-3679-4223-bc5e-3272babde364)
