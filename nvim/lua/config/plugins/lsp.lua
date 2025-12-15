local lsp = vim.lsp
local capabilities = lsp.protocol.make_client_capabilities()
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

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

local M = {}
function M.setup()
  vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
  vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

  require("neodev").setup()
  lspconfig.astro.setup({
    cmd = { "astro-ls", "--stdio" },
    filetypes = { "astro" },
    root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
    init_options = {
      typescript = {
        tsdk = vim.fn.glob(
          vim.loop.cwd() .. "/node_modules/.pnpm/typescript@*/node_modules/typescript/lib",
          false,
          true
        )[1],
      },
    },
  })
  lspconfig.pyright.setup({
    capabilities = capabilities,
    root_dir = util.root_pattern("pyproject.toml", "uv.lock", ".git"),
  })
  lspconfig.rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings= {
      ["rust-analyzer"] = {
        cargo = { allFeatures=true},
        checkOnSave= {command = "clippy"},
      }
    }
  })
  lspconfig.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
      },
    },
  })
  lspconfig.yamlls.setup({
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

  lspconfig.gopls.setup({
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  })
  lspconfig.ts_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

return M
