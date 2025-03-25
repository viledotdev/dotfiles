return {
  "mfussenegger/nvim-lint",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      html = { "eslint_d" },
      css = { "eslint_d" },
      typescript = { "eslint_d" },
      javascript = { "eslint_d" },
      json = { "jsonlint" },
      go = { "golangcilint" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      python = { "pylint" },
    }
    local lint_ag = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_ag,
      callback = function()
        lint.try_lint()
      end,
    })
    vim.keymap.set("n", "<leader>l<leader>", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
