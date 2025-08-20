local dap = require("dap")

-- Use debugpy from Mason if present, else fallback to system Python
local mason_python = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
if vim.fn.executable(mason_python) == 1 then
  dap.adapters.python = {
    type = "executable",
    command = mason_python,
    args = { "-m", "debugpy.adapter" },
  }
else
  dap.adapters.python = {
    type = "executable",
    command = "python",
    args = { "-m", "debugpy.adapter" },
  }
end

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Python: Launch current file",
    program = "${file}",
    cwd = "${workspaceFolder}",
    console = "integratedTerminal",
    justMyCode = true,
  },
  {
    type = "python",
    request = "attach",
    name = "Python: Attach to process",
    processId = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
  },
}
