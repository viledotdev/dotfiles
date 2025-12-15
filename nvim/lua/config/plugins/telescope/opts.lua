-- lua/config/telescope/opts.lua
local M = {}

M.defaults = {
    defaults = {
      layout_strategy = "vertical",
      layout_config = {
        preview_height = 0.9,
        vertical = {
          size = {
            width = "95%",
            height = "95%",
          },
        },
      },
    },
  pickers = {
    find_files = {
      hidden = true,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      case_mode = "smart_case",
    },
  },
}

return M.defaults
