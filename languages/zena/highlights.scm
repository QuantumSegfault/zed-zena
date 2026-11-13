; Zena is parsed with the TypeScript grammar as an approximation. Constructs
; TypeScript does not have (match, sealed, mixin, ...) end up as plain
; identifiers or inside ERROR nodes, so several rules below match on text.

; Identifiers

(identifier) @variable

((identifier) @type
  (#match? @type "^[A-Z]"))

((identifier) @constant
  (#match? @constant "^[A-Z][A-Z0-9_]*$"))

(property_identifier) @property

(shorthand_property_identifier) @property

(shorthand_property_identifier_pattern) @property

(private_property_identifier) @property

; Types

(type_identifier) @type

(predefined_type) @type.builtin

([
  (identifier)
  (type_identifier)
] @type.builtin
  (#any-of? @type.builtin
    "i8" "i16" "i32" "i64" "u8" "u16" "u32" "u64" "f32" "f64" "v128" "boolean" "void" "never"
    "anyref" "ByteArray"))

; Parameters

(required_parameter
  pattern: (identifier) @variable.parameter)

(optional_parameter
  pattern: (identifier) @variable.parameter)

(arrow_function
  parameter: (identifier) @variable.parameter)

; Functions

(function_declaration
  name: (identifier) @function)

(method_definition
  name: (_) @function.method)

(method_signature
  name: (_) @function.method)

(function_signature
  name: (identifier) @function)

(variable_declarator
  name: (identifier) @function
  value: (arrow_function))

(call_expression
  function: (identifier) @function)

(call_expression
  function: (member_expression
    property: (_) @function.method))

; `case Circle(radius: f64)` and `Some(value)` name types, not functions.
(call_expression
  function: (identifier) @type
  (#match? @type "^[A-Z]"))

(method_definition
  name: (property_identifier) @type
  (#match? @type "^[A-Z]"))

(method_signature
  name: (property_identifier) @type
  (#match? @type "^[A-Z]"))

(new_expression
  constructor: (identifier) @type)

; Match arms such as `case Circle: ...` parse as labeled statements.
(statement_identifier) @variable

((statement_identifier) @type
  (#match? @type "^[A-Z]"))

(decorator
  "@" @attribute)

(decorator
  (identifier) @attribute)

(decorator
  (call_expression
    function: (identifier) @attribute))

; Literals

[
  (this)
  (super)
] @variable.special

[
  (true)
  (false)
] @boolean

(null) @constant.builtin

(number) @number

[
  (string)
  (template_string)
] @string

(escape_sequence) @string.escape

(regex) @string.regex

(comment) @comment

((comment) @comment.doc
  (#match? @comment.doc "^/\\*\\*"))

(template_substitution
  "${" @punctuation.special
  "}" @punctuation.special) @embedded

; Punctuation and operators

[
  ";"
  ","
  "."
  ":"
  "?."
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  "="
  "=>"
  "+"
  "-"
  "*"
  "/"
  "%"
  "+="
  "-="
  "*="
  "/="
  "%="
  "&="
  "|="
  "^="
  "<<="
  ">>="
  "=="
  "!="
  "==="
  "!=="
  "<"
  ">"
  "<="
  ">="
  "&&"
  "||"
  "!"
  "&"
  "|"
  "^"
  "~"
  "<<"
  ">>"
  "??"
  "?"
  "..."
] @operator

; Keywords

[
  "abstract"
  "as"
  "async"
  "await"
  "break"
  "case"
  "catch"
  "class"
  "continue"
  "declare"
  "else"
  "enum"
  "export"
  "extends"
  "finally"
  "for"
  "from"
  "function"
  "if"
  "implements"
  "import"
  "in"
  "interface"
  "is"
  "let"
  "new"
  "return"
  "static"
  "throw"
  "try"
  "type"
  "using"
  "var"
  "while"
  "with"
  "yield"
] @keyword

; Zena keywords that TypeScript sees as ordinary names.
([
  (identifier)
  (type_identifier)
  (property_identifier)
] @keyword
  (#any-of? @keyword
    "match" "sealed" "mixin" "distinct" "opaque" "extension" "requires" "ensures" "invariant"
    "final" "inline" "gen"))

; Keywords TypeScript only tokenizes in some positions. Zena uses `if`, `try`
; and `match` as expressions, which TypeScript reads as names.
([
  (identifier)
  (property_identifier)
  (statement_identifier)
] @keyword
  (#any-of? @keyword
    "case" "new" "var" "let" "with" "type" "symbol" "if" "else" "try" "catch" "finally" "throw"
    "while" "for" "return" "break" "continue" "yield" "await"))
