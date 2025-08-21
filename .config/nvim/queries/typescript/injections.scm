; Inject HTML into Angular template property

(pair
  key: (property_identifier) @template_key (#eq? @template_key "template")
  value: (template_string) @html
)
(pair
  key: (property_identifier) @template_key (#eq? @template_key "template")
  value: (string) @html
)

