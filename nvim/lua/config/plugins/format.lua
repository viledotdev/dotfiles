local M = {}
M.setup = function(_, opts)
  local conform = require("conform")

  conform.setup(opts)
  vim.keymap.set({ "n", "v" }, "<leader>mp", function()
    conform.format(opts.format_on_save)
  end, { desc = "Format file or range (in visual mode)" })
end
return M
