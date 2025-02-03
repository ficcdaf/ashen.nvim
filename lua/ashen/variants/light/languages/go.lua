local M = {}

M.dot_link = true
M.name = "go"
M.lsp_attach = true
M.map = {
  ["@lsp.type.type"] = { "blue" },
  ["@lsp.typemod.variable.readonly.go"] = { "blue" },
}
M.link = {

  -- ["@lsp.type.class"] = { link = "Structure" },
  -- ["@lsp.type.decorator"] = { link = "Function" },
  -- ["@lsp.type.enum"] = { link = "Structure" },
  -- ["@lsp.type.enumMember"] = { link = "Constant" },
  -- ["@lsp.type.function"] = { link = "Function" },
  -- ["@lsp.type.interface"] = { link = "Structure" },
  ["@lsp.type.macro"] = "Macro",
  ["@lsp.type.method"] = "@function.method", -- Function
  ["@lsp.type.namespace"] = "@module", -- Structure
  ["@lsp.type.parameter"] = "@variable.parameter", -- Identifier
  -- ["@lsp.type.property"] = { link = "Identifier" },
  -- ["@lsp.type.struct"] = { link = "Structure" },
  -- ["@lsp.type.type"] = { link = "Type" },
  -- ["@lsp.type.typeParameter"] = { link = "TypeDef" },
  ["@lsp.type.variable"] = "@variable", -- Identifier
  ["@lsp.type.comment"] = "@comment", -- Comment
  -- ["@lsp.type.type"] = "gotype",

  ["@lsp.type.selfParameter"] = "@variable.builtin",
  -- ["@lsp.type.builtinConstant"] = { link = "@constant.builtin" },
  ["@lsp.type.builtinConstant"] = "@constant.builtin",
  ["@lsp.type.magicFunction"] = "@function.builtin",

  ["@lsp.mod.readonly"] = "Constant",
  ["@lsp.mod.typeHint"] = "Type",
  -- ["@lsp.mod.defaultLibrary"] = { link = "Special" },
  -- ["@lsp.mod.builtin"] = { link = "Special" },

  ["@lsp.typemod.operator.controlFlow"] = "@keyword.exception",
  ["@lsp.typemod.keyword.documentation"] = "Special",

  ["@lsp.typemod.variable.global"] = "Constant",
  ["@lsp.typemod.variable.static"] = "Constant",
  ["@lsp.typemod.variable.defaultLibrary"] = "Special",

  ["@lsp.typemod.function.builtin"] = "@function.builtin",
  ["@lsp.typemod.function.defaultLibrary"] = "@function.builtin",
  ["@lsp.typemod.method.defaultLibrary"] = "@function.builtin",

  ["@lsp.typemod.operator.injected"] = "Operator",
  ["@lsp.typemod.string.injected"] = "String",
  ["@lsp.typemod.variable.injected"] = "@variable",

  -- ["@lsp.typemod.function.readonly"] = { fg = theme.syn.fun, bold = true },
}

return M
