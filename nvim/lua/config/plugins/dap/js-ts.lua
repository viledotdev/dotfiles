local dap = require("dap")
local mason_path = vim.fn.stdpath("data") .. "/mason"
local js_debug_path = mason_path .. "/packages/js-debug-adapter"

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = { js_debug_path .. "/js-debug/src/dapDebugServer.js", "${port}" },
  },
}

-- Example configuration for JS/TS
dap.configurations.javascript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch current file",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
}

dap.configurations.typescript = dap.configurations.javascript
