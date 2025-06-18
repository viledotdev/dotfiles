local cmp = require("cmp")
local luasnip = require("luasnip")

local M = {}
M.default = {
  ["<left>"] = cmp.mapping.scroll_docs(-4),
  ["<right>"] = cmp.mapping.scroll_docs(4),
  ["<esc>"] = cmp.mapping.abort(),
  ["<down>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.choice_active() then
      luasnip.change_choice(1)
    else
      fallback()
    end
  end, { "i", "s" }),
  ["<up>"] = cmp.mapping.select_prev_item(),
  ["<tab>"] = cmp.mapping.confirm({ select = true }),
  ["<c-space>"] = cmp.mapping.complete(),
}

M.cmdline = {
  search = cmp.mapping.preset.cmdline({
    ["<C-z>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        cmp.complete()
      end
    end, { "c" }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        cmp.complete()
      end
    end, { "c" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "c" }),
  }),
  command = cmp.mapping.preset.cmdline(),
}

return M
