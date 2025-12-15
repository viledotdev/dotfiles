return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
'jonarrien/telescope-cmdline.nvim',
    "xiyaowong/telescope-emoji.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  cmd = "Telescope",
  keys = require("config.plugins.telescope.mappings"),
  opts = require("config.plugins.telescope.opts"),
  main = "config.plugins.telescope.setup",
}
