-- lua/plugins/dap.lua
return {
  { "mfussenegger/nvim-dap", lazy = false },
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "netcoredbg",
        "js-debug-adapter",
        "debugpy",
        "delve",
      },
    },
    config = function()
      require("config.plugins.dap.dotnet")
      require("config.plugins.dap.js-ts")
      require("config.plugins.dap.python")
      require("config.plugins.dap.go")
      require("config.plugins.dap.keys")
    end,
  },
}
