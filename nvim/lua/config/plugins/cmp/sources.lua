local M = {}

M.default = {
  { name = "nvim_lsp" },
  { name = "copilot" },
  { name = "path" },
  { name = "luasnip" },
  { name = "buffer" },
}

M.gitcommit = {
  { name = "git" },
  { name = "buffer" },
}

M.cmdline = {
  search = {
    { name = "buffer" },
  },
  command = {
    { name = "path" },
    { name = "cmdline" },
  },
}

return M
