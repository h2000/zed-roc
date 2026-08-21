#!/usr/bin/env bash

set -euo pipefail

query_file="${1:-languages/roc/highlights.scm}"
supported='@attribute
@boolean
@comment
@comment.doc
@constant
@constant.builtin
@constructor
@embedded
@emphasis
@emphasis.strong
@enum
@function
@hint
@keyword
@label
@link_text
@link_uri
@number
@operator
@predictive
@primary
@property
@punctuation
@punctuation.bracket
@punctuation.delimiter
@punctuation.list_marker
@punctuation.special
@string
@string.escape
@string.regex
@string.special
@string.special.symbol
@tag
@tag.doctype
@text.literal
@title
@type
@type.builtin
@variable
@variable.parameter
@variable.special
@variant'

invalid="$({ sed 's/;.*$//' "$query_file" \
  | rg -o '@[A-Za-z][A-Za-z0-9_.-]*' \
  | sort -u \
  | comm -23 - <(printf '%s\n' "$supported" | sort -u); } || true)"

if [[ -n "$invalid" ]]; then
  printf 'Unsupported Zed highlight captures in %s:\n%s\n' "$query_file" "$invalid" >&2
  exit 1
fi

printf 'All highlight captures in %s are supported by Zed.\n' "$query_file"
