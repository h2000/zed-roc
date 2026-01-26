(file
  (opaque_type_def
    (apply_type
      (concrete_type) @name)) @item)

(file
  (alias_type_def
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
