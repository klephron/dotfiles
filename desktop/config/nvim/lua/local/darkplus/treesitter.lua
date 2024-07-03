local M = {}

function M.get(group)
  local tsgroup = M.deprecated[group]
  if tsgroup then
    return "@" .. tsgroup
  else
    return group
  end
end

M.deprecated = {
  ["TSAnnotation"] = "annotation",
  ["TSAttribute"] = "attribute",
  ["TSBoolean"] = "boolean",
  ["TSCharacter"] = "character",
  ["TSCharacterSpecial"] = "character.special",
  ["TSComment"] = "comment",
  ["TSConditional"] = "conditional",
  ["TSConstant"] = "constant",
  ["TSConstBuiltin"] = "constant.builtin",
  ["TSConstMacro"] = "constant.macro",
  ["TSConstructor"] = "constructor",
  ["TSDebug"] = "debug",
  ["TSDefine"] = "define",
  ["TSError"] = "error",
  ["TSException"] = "exception",
  ["TSField"] = "field",
  ["TSFloat"] = "float",
  ["TSFunction"] = "function",
  ["TSFunctionCall"] = "function.call",
  ["TSFuncBuiltin"] = "function.builtin",
  ["TSFuncMacro"] = "function.macro",
  ["TSInclude"] = "include",
  ["TSKeyword"] = "keyword",
  ["TSKeywordFunction"] = "keyword.function",
  ["TSKeywordOperator"] = "keyword.operator",
  ["TSKeywordReturn"] = "keyword.return",
  ["TSLabel"] = "label",
  ["TSMethod"] = "method",
  ["TSMethodCall"] = "method.call",
  ["TSNamespace"] = "namespace",
  ["TSNone"] = "none",
  ["TSNumber"] = "number",
  ["TSOperator"] = "operator",
  ["TSParameter"] = "parameter",
  ["TSParameterReference"] = "parameter.reference",
  ["TSPreProc"] = "preproc",
  ["TSProperty"] = "property",
  ["TSPunctDelimiter"] = "punctuation.delimiter",
  ["TSPunctBracket"] = "punctuation.bracket",
  ["TSPunctSpecial"] = "punctuation.special",
  ["TSRepeat"] = "repeat",
  ["TSStorageClass"] = "storageclass",
  ["TSString"] = "string",
  ["TSStringRegex"] = "string.regex",
  ["TSStringEscape"] = "string.escape",
  ["TSStringSpecial"] = "string.special",
  ["TSSymbol"] = "symbol",
  ["TSTag"] = "tag",
  ["TSTagAttribute"] = "tag.attribute",
  ["TSTagDelimiter"] = "tag.delimiter",
  ["TSText"] = "text",
  ["TSStrong"] = "text.strong",
  ["TSEmphasis"] = "text.emphasis",
  ["TSUnderline"] = "text.underline",
  ["TSStrike"] = "text.strike",
  ["TSTitle"] = "text.title",
  ["TSLiteral"] = "text.literal",
  ["TSURI"] = "text.uri",
  ["TSMath"] = "text.math",
  ["TSTextReference"] = "text.reference",
  ["TSEnvironment"] = "text.environment",
  ["TSEnvironmentName"] = "text.environment.name",
  ["TSNote"] = "text.note",
  ["TSWarning"] = "text.warning",
  ["TSDanger"] = "text.danger",
  ["TSTodo"] = "todo",
  ["TSType"] = "type",
  ["TSTypeBuiltin"] = "type.builtin",
  ["TSTypeQualifier"] = "type.qualifier",
  ["TSTypeDefinition"] = "type.definition",
  ["TSVariable"] = "variable",
  ["TSVariableBuiltin"] = "variable.builtin",
}

M.defaults = {}

return M
