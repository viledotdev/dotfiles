local ls = require("luasnip")
local util = require("luasnip.util.types")

-- Función para cargar todos los snippets de una carpeta
local function load_snippets_from_folder(folder)
  local snippets = {}
  -- Obtener la ruta absoluta de la carpeta (ajústala según tu configuración)
  local config_path = vim.fn.stdpath("config")
  local folder_path = config_path .. "/lua/config/plugins/snippets/" .. folder

  -- Obtener la lista de archivos .lua en la carpeta
  local files = vim.fn.readdir(folder_path)
  for _, file in ipairs(files) do
    -- Quitar la extensión .lua para poder requerir el módulo
    local module_name = file:gsub("%.lua$", "")
    local loaded = require("config.plugins.snippets." .. folder .. "." .. module_name)
    -- Supongamos que cada archivo retorna una tabla de snippets
    for _, snippet in ipairs(loaded) do
      table.insert(snippets, snippet)
    end
  end
  return snippets
end

local ts_snippets = load_snippets_from_folder("typescript")
local lua_snippets = load_snippets_from_folder("lua")
local python_snippets = load_snippets_from_folder("python")
local md_snippets = load_snippets_from_folder("markdown")

local M = {}
function M.setup()
  ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    ext_opts = {
      [util.choiceNode] = {
        active = {
          virt_text = { { "<- Choice", "Error" } },
        },
      },
    },
  })

  ls.add_snippets("typescript", ts_snippets)
  ls.add_snippets("javascript", ts_snippets)
  ls.add_snippets("lua", lua_snippets)
  ls.add_snippets("python", python_snippets)
  ls.add_snippets("markdown", md_snippets)

  vim.keymap.set({ "i" }, "<c-e>", function()
    ls.expand()
  end, { silent = true })
  vim.keymap.set({ "i", "s" }, "<c-n>", function()
    if ls.expand_or_jumpable() then
      ls.expand_or_jump()
    end
  end, { silent = true })
  vim.keymap.set({ "i", "s" }, "<c-t>", function()
    if ls.jumpable(-1) then
      ls.jump(-1)
    end
  end, { silent = true })
end

return M
