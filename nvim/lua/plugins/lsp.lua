return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "folke/neodev.nvim",
  },
  config = function()
    local diag = vim.diagnostic
    local lsp = vim.lsp
    vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
    vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)
    local on_attach = function(_, buffnumber)
      vim.bo[buffnumber].omnifunc = "v:lua.lsp.omnifunc"
      local opts = { buffer = buffnumber }
      vim.keymap.set("n", "gD", lsp.buf.declaration, opts)
      vim.keymap.set("n", "gd", lsp.buf.definition, opts)
      vim.keymap.set("n", "K", lsp.buf.hover, opts)
      vim.keymap.set("n", "gi", lsp.buf.implementation, opts)
      vim.keymap.set("n", "<C-k>", lsp.buf.signature_help, opts)
      vim.keymap.set("n", "<space>D", lsp.buf.type_definition, opts)
      vim.keymap.set("n", "<space>rn", lsp.buf.rename, opts)
      vim.keymap.set({ "n", "v" }, "<space>ca", lsp.buf.code_action, opts)
      vim.keymap.set("n", "gr", lsp.buf.references, opts)
    end
    local capabilities = lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    require("neodev").setup()
    require("lspconfig").lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          workspace = { checkThirdParty = false },
        },
      },
    })
    require("lspconfig").yamlls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        yaml = {
          workspace = { checkThirdParty = false },
          schemas = {
            ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
            ["../path/relative/to/file.yml"] = "/.github/workflows/*",
            ["/path/from/root/of/project"] = "/.github/workflows/*",
          },
        },
      },
    })
    require("lspconfig").gopls.setup({
      cmd = { "gopls" },
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"),
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
        },
      },
    })
    require("lspconfig").ts_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
}
