local ls = require("luasnip")
local types = require("luasnip.util.types")
local md_snippets = require("config.plugins.snippets.md_snippets")
local python_snippets = require("config.plugins.snippets.python_snippets")
local typescript_snippets = require("config.plugins.snippets.typescript_snippets")
local lua_snippets = require("config.plugins.snippets.lua_snippets")

local M = {}
function M.setup()
  ls.config.set_config({
    history = true,
    updateevents = "TextChanged, TextChangedI",
    enable_autosnippets = true,
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { "<- Choice", "Error" } },
        },
      },
    },
  })

  ls.add_snippets("lua", lua_snippets)
  ls.add_snippets("javascript", typescript_snippets)
  ls.add_snippets("typescript", typescript_snippets)
  ls.add_snippets("python", python_snippets)
  ls.add_snippets("markdown", md_snippets)

  vim.keymap.set({ "i" }, "<c-e>", function()
    ls.expand()
  end, { silent = true })
  vim.keymap.set({ "i", "s" }, "<c-n>", function()
    if ls.expand_or_jumpable() then
      ls.expand_or_jump()
    end
  end, { silent = true })
  vim.keymap.set({ "i", "s" }, "<c-t>", function()
    if ls.jumpable(-1) then
      ls.jump(-1)
    end
  end, { silent = true })
end

return M
