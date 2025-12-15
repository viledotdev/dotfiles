local builtin = require("telescope.builtin")
local themes  = require("telescope.themes")
local pickers = require("config.plugins.telescope.pickers")

local M = {}

local function dropdown_no_preview(picker)
  return function()
    picker(themes.get_dropdown({
      previewer = false,
      winblend = 10,
    }))
  end
end

-- Archivos
table.insert(M, { "<leader>tt", dropdown_no_preview(builtin.find_files), desc = "Find files" })
table.insert(M, { "<leader>tg", builtin.live_grep,                      desc = "Live grep" })
table.insert(M, { "<leader>tb", builtin.buffers,                        desc = "Buffers" })
table.insert(M, { "<leader>t?", builtin.help_tags,                      desc = "Help tags" })
table.insert(M, { "<leader>tp", pickers.picker_launcher,                      desc = "Help tags" })
table.insert(M, { "<leader>th", pickers.file_browser_here ,desc = "Help tags" })
table.insert(M, { "<leader>tH", pickers.file_browser_cwd ,desc = "Help tags" })

-- Git
table.insert(M, { "<leader>gc", builtin.git_commits,    desc = "Git commits" })
table.insert(M, { "<leader>gC", builtin.git_bcommits,   desc = "Git buffer commits" })
table.insert(M, { "<leader>gs", builtin.git_status,     desc = "Git status" })

-- LSP
table.insert(M, { "gr", builtin.lsp_references,         desc = "LSP references" })
table.insert(M, { "gd", builtin.lsp_definitions,        desc = "LSP definitions" })
table.insert(M, { "gi", builtin.lsp_implementations,    desc = "LSP implementations" })

-- Treesitter
table.insert(M, { "<leader>ts", builtin.treesitter,     desc = "Treesitter symbols" })

-- Buscar palabra bajo el cursor
table.insert(M, { "<leader>*", builtin.grep_string,     desc = "Grep word under cursor" })

return M
