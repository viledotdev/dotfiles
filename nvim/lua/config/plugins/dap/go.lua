local dap = require("dap")

-- Path to delve (from Mason if installed)
local mason_dlv = vim.fn.stdpath("data") .. "/mason/bin/dlv"
local dlv_cmd = (vim.fn.executable(mason_dlv) == 1) and mason_dlv or "dlv"

dap.adapters.go = {
  type = "server",
  port = "${port}",
  executable = {
    command = dlv_cmd,
    args = { "dap", "-l", "127.0.0.1:${port}" },
  },
}

dap.configurations.go = {
  {
    type = "go",
    name = "Debug file",
    request = "launch",
    program = "${file}",
  },
  {
    type = "go",
    name = "Debug package",
    request = "launch",
    program = "${fileDirname}",
  },
  {
    type = "go",
    name = "Attach to process",
    request = "attach",
    processId = require("dap.utils").pick_process,
    mode = "local",
  },
}
