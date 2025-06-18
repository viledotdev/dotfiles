local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

local sources = require("config.plugins.cmp.sources")
local mappings = require("config.plugins.cmp.mappings")
local snippets = require("config.plugins.cmp.snippets")
local events = require("config.plugins.cmp.events")

local M = {}
function M.setup()
  cmp.setup({
    snippet = snippets.default,
    mapping = mappings.default,
    sources = sources.default,
  })

  cmp.setup.filetype("gitcommit", {
    sources = sources.gitcommit,
  })

  cmp.setup.cmdline({ "/", "?" }, {
    mapping = mappings.cmdline.search,
    sources = sources.cmdline.search,
  })
  cmp.setup.cmdline(":", {
    mapping = mappings.cmdline.command,
    sources = sources.cmdline.command,
  })

  events.on_confirm_done({ cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }) })
end

return M
