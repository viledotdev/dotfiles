local pickers      = require("telescope.pickers")
local finders      = require("telescope.finders")
local actions      = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf         = require("telescope.config").values
local builtin = require("telescope.builtin")
local extensions = require("telescope").extensions

local M = {}

M.picker_launcher = function()
  local options = {
    { name = "🗂 File Browser",      picker = extensions.file_browser.file_browser },
    { name = "📁 Find Files",         picker = builtin.find_files },
    { name = "🔍 Live Grep",         picker = builtin.live_grep },
    { name = "📌 Buffers",           picker = builtin.buffers },
    { name = "🌳 Treesitter Symbols", picker = builtin.treesitter },
    { name = "🧠 LSP References",    picker = builtin.lsp_references },
    { name = "🔧 LSP Symbols",       picker = builtin.lsp_document_symbols },
    { name = "🕰 Git Commits",       picker = builtin.git_commits },
    { name = "🔀 Git Status",        picker = builtin.git_status },
  }

  pickers.new({}, {
    prompt_title = " Telescope Picker Launcher",
    finder = finders.new_table({
      results = options,
      entry_maker = function(entry)
        return {
          value = entry.picker,
          display = entry.name,
          ordinal = entry.name,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        selection.value() -- 🔥 EJECUTA EL PICKER SELECCIONADO
      end)
      return true
    end,
  }):find()
end

M.file_browser_here = function()
  require("telescope").extensions.file_browser.file_browser({
    path = vim.fn.expand("%:p:h"), 
    select_buffer = true,
    hidden = true,                   })
end
M.file_browser_cwd = function()
  require("telescope").extensions.file_browser.file_browser({
    path = vim.loop.cwd(),
    select_buffer = false,
    hidden = true,
  })
end

return M
