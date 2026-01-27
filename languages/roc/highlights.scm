(identifier) @variable



[
  (concrete_type)
  (tag_type)] @type



(module) @namespace



;;
;; Lower-priorty queries
;;



(argument_patterns                (identifier_pattern (identifier) @variable.parameter))
(argument_patterns (_             (identifier_pattern (identifier) @variable.parameter)))
(argument_patterns (_ (_          (identifier_pattern (identifier) @variable.parameter))))
(argument_patterns (_ (_ (_       (identifier_pattern (identifier) @variable.parameter)))))
(argument_patterns (_ (_ (_ (_    (identifier_pattern (identifier) @variable.parameter))))))
(argument_patterns (_ (_ (_ (_ (_ (identifier_pattern (identifier) @variable.parameter)))))))
(spread_pattern                                       (identifier) @variable.parameter)
(match_branch pattern: (_       (identifier_pattern (identifier) @variable.parameter)))

; N/A
; @variable.other.member.private

(field_name)                         @variable.other.member
; Note: This query matches the second identifier and all subsequent ones.
(field_access_expr      (identifier) @variable.other.member)
; Note: This query highlights module members as records instead of free variables,
;       which avoids highlighting them as out-of-scope vars.
(variable_expr (module) (identifier) @variable.other.member)

; N/A
; @variable.other

; N/A
; @variable.builtin

(record_field_pattern (_ (identifier) @variable))

; Note: See the lower-priority queries below for a `@variable` query.



(inferred) @type.roc-special.inferred

(bound_variable) @type.parameter

(tag_type) @type.enum.variant

; N/A
; @type.enum

; Opinion: Type defs cross into documentation
;          and should be highlighted differently from normal code.
(opaque_type_def (_ (concrete_type) @type.definition))

((concrete_type) @type.builtin
  (#match? @type.builtin "^(Dec|F(32|64))"))
((concrete_type) @type.builtin
  (#match? @type.builtin "^[IU](8|16|32|64|128)"))
((concrete_type) @type.builtin
  (#match? @type.builtin "^(Bool|Box|Dec|Decode|Dict|Encode|Hash|Inspect|Int|List|Num|Result|Set|Str)"))

; Note: See the lower-priority queries below for a `@type` query.



; N/A
; @tag.builtin

; N/A (We use `@constructor` and `@type.enum.variant` for "tags".)
; @tag



(app_header (packages_list (platform_ref ((package_uri) @string.special.url))))




(app_header (packages_list (platform_ref ((package_uri) @string.special.url))))

; N/A
; @string.special.symbol

; N/A
; @string.special.path

; N/A
; @string.special

; N/A
; @string.regexp

(string) @string
(multiline_string) @string



; TODO: Differentiate between values, functions, and types.
(import_expr (exposing ((ident) @special.roc-special.exposed)))

(app_header (packages_list ((platform_ref) @special.roc-special.package)))

; TODO: Differentiate between values, functions, and types.
(app_header (provides_list ((identifier) @special.roc-special.provided)))

; N/A
; @special



[
  (interpolation_char)
] @punctuation.special

[
  ","
  ":"
  (arrow)
  (fat_arrow)
] @punctuation.delimiter

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
  "|" ; TODO: This conflicts with the `"|" @operator` query, so improve both.
] @punctuation.bracket

; N/A
; @punctuation



[
  "="
  "."
  "&"
  ; "|" ; TODO: This conflicts with the `"|" @punctuation.bracket` query, so improve both.
  "<-"
  "->"
  ".."
  "!"
  "*"
  "-"
  "^"
  (wildcard_pattern)
  (operator)
] @operator



; N/A
; @label



; TODO: Implement this for `var`.
; @keyword.storage.type

; N/A
; @keyword.storage.modifier

; TODO: Implement this for `and`, `or`, and any others.
[
   (suffix_operator)
  ] @keyword.operator

; N/A
; @keyword.function

; N/A
; @keyword.directive

; TODO: Also implement this for `return`.
[(suffix_operator ) "return"]@keyword.control.return

; TODO: Implement this for `for` and `while`.
; @keyword.control.repeat

[
  "import"
] @keyword.control.import

; N/A
; @keyword.control.exception

[
  "else"
  "if"

  (match)
] @keyword.control.conditional

[
  "app"
  (as)
  "as"
  "expect"
  "exposing"
  "module"
  "package"
  "platform"
  (to)
  "var"
  (where)
] @keyword.control

; N/A
;
; @keyword



[
  "dbg"
] @function.builtin

(value_declaration (decl_left (identifier_pattern  (identifier) @function))
  (expr_body (anon_fun_expr)))
(function_call_pnc_expr caller: (variable_expr     (identifier) @function))
(function_call_pnc_expr caller: (field_access_expr (identifier) @function .))
(bin_op_expr (operator "->") (variable_expr        (identifier) @function))
(annotation_type_def (annotation_pre_colon         (identifier) @function)
  (function_type))



  (tag (identifier)@constructor)




[
  (decimal)
  (float)
] @constant.numeric.float

[
  (iint)
  (int)
  (natural)
  (uint)
  (xint)
] @constant.numeric.integer

; N/A
; @constant.numeric

(escape_char) @constant.character.escape

(char) @constant.character

(tag_expr(tag (module) @ignoreme.module "." (identifier)@constant.builtin.boolean)
  (#eq? @constant.builtin.boolean "True") (#eq? @ignoreme.module "Bool"))
(tag_expr (tag(module) @module "." (identifier)@constant.builtin.boolean)
  (#eq? @constant.builtin.boolean "False") (#eq? @module "Bool"))

; N/A
; @constant.builtin

; N/A
; @constant



(line_comment) @comment.line

(doc_comment) @comment.block.documentation

; N/A
; @comment.block

; N/A
; @comment



; N/A
; @attribute



(record_field_type (field_name) @variable.other.member.roc-special.in-typedef)


(function_type "," @punctuation.delimiter.roc-special.in-typedef)
(record_type   "," @punctuation.delimiter.roc-special.in-typedef)
(tuple_type    "," @punctuation.delimiter.roc-special.in-typedef)

(parenthesized_type ["(" ")"] @punctuation.bracket.roc-special.in-typedef)
(record_type        ["{" "}"] @punctuation.bracket.roc-special.in-typedef)
(tags_type          ["[" "]"] @punctuation.bracket.roc-special.in-typedef)
(tuple_type         ["(" ")"] @punctuation.bracket.roc-special.in-typedef)

(static_dispatch_target
(identifier)@function.method)


((module) @namespace.roc-special.builtin
  (#match? @namespace.roc-special.builtin "^(Bool|Box|Decode|Dict|Encode|Hash|Inspect|List|Num|Result|Set|Str)"))
; TODO(bugfix): `Set` yields an ERROR in `expect Set.from_list(paths_as_str) == Set.from_list(["nested-dir/a", "nested-dir/child"])`



;;
;; Higher-priorty queries
;;



;; Highlight names (like `@comment.block.documentation`) are arbitrary.
;; However, some text editors encourage a standard set in their themes.
;; For consistency and quality, these queries assign the highlight names that Helix uses:
;; see https://docs.helix-editor.com/themes.html#scopes
