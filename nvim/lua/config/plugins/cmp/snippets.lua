local luasnip = require("luasnip")

local M = {}

M.default = {
  expand = function(args)
    luasnip.lsp_expand(args.body)
  end,
}

return M
