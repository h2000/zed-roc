# Roc lang support for Zed

An extension for Zed that adds Roc language support:

- syntax highlighting through treesitter and
- type tooltips, error marker, completion ... through the roc language server

## Preqrequisites

- install roc from the [roc-lang](https://roc-lang.org) website
- add roc and roc_language_server to your PATH
- install Zed from the [Zed](https://zed.dev) website

## ROC

- Website: [roc-lang.org](https://roc-lang.org)
- Tree Sitter: [tree-sitter-roc](https://github.com/faldor20/tree-sitter-roc)
- Language Server: [roc-language-server](https://github.com/roc-lang/roc/tree/main) included in nightly builds of the ROC compiler e.g. https://github.com/roc-lang/roc/releases/download/nightly/roc_nightly-macos_apple_silicon-latest.tar.gz, the roc_language_server binary should be included in PATH.

## Development

```sh
~/Library/Application\ Support/Zed/extensions/installed/
less ~/Library/Logs/Zed/Zed.log
```

![Zed Example](https://github.com/h2000/zed-roc/assets/187650/1ec0cda3-3679-4223-bc5e-3272babde364)
