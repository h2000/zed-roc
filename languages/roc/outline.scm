(file
  (nominal_type_def
    (apply_type
      (concrete_type) @name)) @item)

(file
  (opaque_type_def
    (apply_type
      (concrete_type) @name)) @item)

(file
  (alias_type_def
    (apply_type
      (concrete_type) @name)) @item)

(file
  (nominal_type_def
    (apply_type
      (concrete_type) @name)) @item)

(file
  (annotation_type_def
    (annotation_pre_colon
    (identifier) @name)) @item)

(file
  (value_declaration
    (decl_left
      (identifier_pattern
      (identifier) @name))) @item)

(file
  (var_declaration
    name: (identifier) @name) @item)

(nominal_methods
  (value_declaration
    (decl_left
      (identifier_pattern
      (identifier) @name))) @item)
