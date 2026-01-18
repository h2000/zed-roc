;;----comments----

[
  (line_comment)
  (doc_comment) @comment.block.documentation
] @comment

;;----typedefs-----

;; opinion: typedefs cross into documentation and should be
;; highlighted differently from normal code

(nominal_type_def (_ (concrete_type) @type.definition))
(function_type (arrow) @punctuation.delimiter.structural.typedef)
(function_type (effect_arrow) @punctuation.delimiter.structural.typedef)

(parenthesized_type ["(" ")"] @punctuation.bracket.typedef)
(tuple_type ["(" ")"] @punctuation.bracket.typedef)
(record_type ["{" "}"] @punctuation.bracket.typedef)
(tags_type ["[" "]"] @punctuation.bracket.typedef)

(function_type "," @punctuation.delimiter.typedef)
(tuple_type "," @punctuation.delimiter.typedef)
(record_type "," @punctuation.delimiter.typedef)
(record_field_type ":" @punctuation.delimiter.typedef)

(record_field_type (field_name) @variable.other.enum.typedef)
(where_clause
  (where) @type.keyword)

((concrete_type) @type.builtin
  (#match? @type.builtin "^(Bool|Str|Num|List|Result|Dict|Set|Dec)"))
((concrete_type) @type.builtin
  (#match? @type.builtin "^[IU](8|16|32|64|128)"))
((concrete_type) @type.builtin
  (#match? @type.builtin "^F(32|64)"))

(bound_variable) @type.parameter
(tags_type (apply_type(concrete_type) @type.enum.variant))

(concrete_type) @type

;;-----Punctuation----
[
"?"
(arrow)
(back_arrow)
] @punctuation.delimiter.structural

; Lambda pipes
(anon_fun_expr "|" @punctuation.delimiter.structural)
(bang_expr "!" @punctuation.delimiter.structural)
[
  ","
  ":"
] @punctuation.delimiter


[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
  (interpolation_char)
] @punctuation.bracket

[
  "|"
  "&"
  ".."
  (operator)
  (wildcard_pattern)
] @operator

[
  "if"
  "else"
] @keyword.control.conditional

[
"match"
"as"
(to)
] @keyword.control.roc

; Match expression fat arrow
(match_branch "=>" @punctuation.delimiter.structural)

;----headers-----

[
  "app"
  "expect"
  "module"
  "package"
  "import"
 ] @keyword.control

;---annotations----

(annotation_type_def
 (annotation_pre_colon
  (identifier)@function )
 (function_type))

(annotation_type_def
 (annotation_pre_colon
  (identifier)@parameter.definition ))


;----decleration types----
(value_declaration(decl_left
  (identifier_pattern
   (identifier)@function.definition))(expr_body(anon_fun_expr)))

(value_declaration(decl_left
  (identifier_pattern
   (identifier) @parameter.definition)))

(backpassing_expr assignee: (identifier_pattern (identifier) @parameter.definition))

;----tags----

(tag)@constructor
(opaque_tag)@constructor

;-----builtins----

(variable_expr
  (module)@module
  (identifier)@constant.builtin.boolean
  (#eq? @constant.builtin.boolean "true" )
  (#eq? @module "Bool" )
  )
(variable_expr
  (module)@module
  (identifier)@constant.builtin.boolean
  (#eq? @constant.builtin.boolean "false" )
  (#eq? @module "Bool" )
  )
[
"dbg"
] @constant.builtin
;----function invocations ----
(function_call_expr
  caller:  (variable_expr
      (identifier)@function))

(function_call_expr
  caller: (field_access_expr (identifier)@function .))

;----function arguments----

(argument_patterns(identifier_pattern
                (identifier)@variable.parameter))
(argument_patterns(_(identifier_pattern(identifier)@variable.parameter)))
(argument_patterns(_(_(identifier_pattern(identifier)@variable.parameter))))
(argument_patterns(_(_(_(identifier_pattern(identifier)@variable.parameter)))))
(argument_patterns(_(_(_(_(identifier_pattern(identifier)@variable.parameter))))))
(argument_patterns(_(_(_(_(_(identifier_pattern(identifier)@variable.parameter)))))))

; pattern captures
(match_branch pattern: (_ (identifier_pattern (identifier) @variable.parameter)))
(range_pattern (identifier) @variable.parameter)


;;----records----

(field_name)@variable.other.member
(record_field_pattern (_(identifier) @variable))



;matches the second identifier and all subsequent ones
(field_access_expr (identifier) @variable.other.member)

;highlight module members as records instead of free variables
; avoids highlighting them as out-of-scope vars
(variable_expr (module) (identifier) @variable.other.member)

;-----consts-----
[
  (int)
  (uint)
  (iint)
  (xint)
  (natural)
] @constant.numeric.integer
[
  (decimal)
  (float)
] @constant.numeric.float

(string)@string
(multiline_string)@string
(line_string)@string
(char) @constant.character
(escape_char)@constant.character.escape

;---keep most generic types at bottom for helix---
;; #any-of? not working in the tree-sitter for helix 23.10
((module) @namespace.builtin (#eq? @namespace.builtin "Bool"))
((module) @namespace.builtin (#eq? @namespace.builtin "Str"))
((module) @namespace.builtin (#eq? @namespace.builtin "Num"))
((module) @namespace.builtin (#eq? @namespace.builtin "List"))
((module) @namespace.builtin (#eq? @namespace.builtin "Result"))
((module) @namespace.builtin (#eq? @namespace.builtin "Dict"))
((module) @namespace.builtin (#eq? @namespace.builtin "Set"))
(module)@namespace
(module)@module

(identifier)@variable

