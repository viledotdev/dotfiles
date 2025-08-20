-- C#/.NET debugging via netcoredbg + nice UI + handy keymaps

local dap = require("dap")
local ok_ui, dapui = pcall(require, "dapui")

-- Resolve netcoredbg from Mason (fallback to system if not found)
local mason_dbg = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg"
local dbg_cmd = (vim.fn.executable(mason_dbg) == 1) and mason_dbg or "netcoredbg"

dap.adapters.coreclr = {
  type = "executable",
  command = dbg_cmd,
  args = { "--interpreter=vscode" },
}

-- Helper: try to auto-pick a non-test DLL from common TFM paths
local function find_debug_dll()
  local cwd = vim.fn.getcwd()
  local patterns = {
    "/bin/Debug/net9.0/*.dll",
    "/bin/Debug/net8.0/*.dll",
    "/bin/Debug/*/*.dll", -- fallback for other TFMs
  }
  for _, pat in ipairs(patterns) do
    local matches = vim.fn.glob(cwd .. pat, true, true)
    for _, dll in ipairs(matches) do
      if not dll:lower():match("test") then
        return dll
      end
    end
  end
  return nil
end

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "Launch .NET",
    request = "launch",
    program = function()
      -- Build in background; remove if you prefer manual build
      vim.fn.jobstart("dotnet build", { detach = true })
      local dll = find_debug_dll()
      if dll then
        return dll
      end
      return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
    end,
  },
  {
    -- Useful for ASP.NET Core apps started externally, or `dotnet run` in another terminal
    type = "coreclr",
    name = "Attach to process",
    request = "attach",
    processId = function()
      -- Simple process picker
      local procs = vim.fn.systemlist("ps -ax | grep dotnet | grep -v grep")
      local choices = {}
      for _, p in ipairs(procs) do
        local pid = p:match("^%s*(%d+)")
        if pid then
          table.insert(choices, pid .. "  " .. p)
        end
      end
      if #choices == 0 then
        vim.notify("No dotnet processes found", vim.log.levels.WARN)
        return nil
      end
      local choice = vim.fn.inputlist(vim.list_extend({ "Select process:" }, choices))
      if choice < 1 or choice > #choices then
        return nil
      end
      return choices[choice]:match("^(%d+)")
    end,
  },
}

-- Optional UI (auto-open/close)
if ok_ui then
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
end

-- Keymaps
local map = vim.keymap.set
map("n", "<F5>", dap.continue, { desc = "DAP Continue/Start" })
map("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
map("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
map("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })
map("n", "<leader>b", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
map("n", "<leader>B", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "DAP Conditional Breakpoint" })
map("n", "<leader>dr", dap.repl.open, { desc = "DAP REPL" })
map("n", "<leader>dl", dap.run_last, { desc = "DAP Run Last" })
