return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  opts = {
    defaults = {
      layout_strategy = "vertical",
      layout_config = {
        preview_height = 0.7,
        vertical = {
          size = {
            width = "95%",
            height = "95%",
          },
        },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
    },
  },
  config = function(opts)
    require("telescope").setup(opts)
    require("telescope").load_extension("fzf")
  end,
  keys = {
    -- Generic
    {
      "<leader>tgs",
      function()
        require("telescope.builtin").grep_string()
      end,
      desc = "Search for string on current directory",
    },
    {
      "<leader>cmd",
      function()
        require("telescope.builtin").commands()
      end,
      desc = "Telescope Git Files",
    },
    {
      "<leader>km",
      function()
        require("telescope.builtin").keymaps()
      end,
      desc = "List keymaps",
    },
    {
      "<leader>tb",
      function()
        require("telescope.builtin").buffers()
      end,
      desc = "Telescope buffers",
    },
    {
      "<leader>tp",
      function()
        require("telescope.builtin").find_files({
          prompt_title = "Plugins",
          cwd = vim.fn.stdpath("config") .. "/lua/plugins",
          attach_mappings = function(_, map)
            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")
            map("i", "<cr>", function(prompt_bufnr)
              local new_plugin = action_state.get_current_line()
              actions.close(prompt_bufnr)
              vim.cmd(string.format("edit ~/.config/nvim/lua/plugins/%s.lua", new_plugin))
            end)
            return true
          end,
        })
      end,
    },
    {
      "<leader>t<leader>",
      function()
        require("telescope.builtin").find_files()
      end,
      desc = "Telescope Find Files",
    },
    {
      "<leader>t?",
      function()
        require("telescope.builtin").help_tags()
      end,
      desc = "Telescope Help",
    },
    {
      "<leader>th",
      function()
        require("telescope").extensions.file_browser.file_browser({ path = "%:h:p", select_buffer = true })
      end,
      desc = "Telescope file browser",
    },
    -- Obsidian
    {
      "<leader>tos",
      function()
        require("telescope.builtin").live_grep({
          search_dirs = { "/Users/victor/Library/Mobile\\ Documents/iCloud~md~obsidian/Documents/notes" },
        })
      end,
      desc = "Obsidian search in files",
    },
    {
      "<leader>toth",
      function()
        require("telescope").extensions.file_browser.file_browser({
          search_dirs = "/Users/victor/Library/Mobile\\ Documents/iCloud~md~obsidian/Documents/notes",
          select_buffer = true,
        })
      end,
      desc = "Obsidian file browser",
    },
    {
      "<leader>to<leader>",
      function()
        require("telescope.builtin").find_files({
          search_dirs = { "/Users/victor/Library/Mobile\\ Documents/iCloud~md~obsidian/Documents/notes" },
        })
      end,
      desc = "Obsidian find files",
    },
    -- Git
    {
      "<leader>gs",
      function()
        require("telescope.builtin").git_status()
      end,
      desc = "Telescope Git status",
    },
    {
      "<leader>gc",
      function()
        require("telescope.builtin").git_bcommits()
      end,
      desc = "Telescope Git status",
    },
    {
      "<leader>gb",
      function()
        require("telescope.builtin").git_branches()
      end,
      desc = "Telescope Git branches",
    },
  },
}
