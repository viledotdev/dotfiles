local ok, dap = pcall(require, "dap")
if not ok then
  return
end

-- Optional: UI toggle (works if nvim-dap-ui is installed)
local has_ui, dapui = pcall(require, "dapui")
if has_ui then
  -- one-time setup if you haven’t centralized it elsewhere
  if not vim.g._dapui_setup_done then
    dapui.setup()
    dap.listeners.after.event_initialized["dapui_auto_open"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_auto_close"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_auto_close"] = function()
      dapui.close()
    end
    vim.g._dapui_setup_done = true
  end
end

-- Pretty signs (optional)
vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "→", texthl = "DiagnosticWarn", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DiagnosticHint", numhl = "" })

local map = vim.keymap.set
local desc = function(d)
  return { silent = true, desc = d }
end

-- Core
map("n", "<F5>", dap.continue, desc("DAP Continue/Start"))
map("n", "<F10>", dap.step_over, desc("DAP Step Over"))
map("n", "<F11>", dap.step_into, desc("DAP Step Into"))
map("n", "<F12>", dap.step_out, desc("DAP Step Out"))
map("n", "<leader>dr", dap.repl.open, desc("DAP REPL"))
map("n", "<leader>dl", dap.run_last, desc("DAP Run Last"))
map("n", "<leader>dt", dap.terminate, desc("DAP Terminate"))
map("n", "<leader>dP", dap.pause, desc("DAP Pause"))

-- Breakpoints
map("n", "<leader>b", dap.toggle_breakpoint, desc("DAP Toggle Breakpoint"))
map("n", "<leader>B", function()
  dap.set_breakpoint(vim.fn.input("Condition: "))
end, desc("DAP Conditional Breakpoint"))
map("n", "<leader>db", function()
  dap.set_breakpoint(nil, nil, vim.fn.input("Log point: "))
end, desc("DAP Log Point"))
map("n", "<leader>dC", function()
  dap.clear_breakpoints()
end, desc("DAP Clear Breakpoints"))

-- UI
if has_ui then
  map("n", "<leader>du", dapui.toggle, desc("DAP UI Toggle"))
end
