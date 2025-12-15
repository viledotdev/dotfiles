return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "config.plugins.format",
  opts = {
    formatters = {
      shfmt = {
        args = {
          "-i",
          "2", -- Cambia el número para ajustar la cantidad de espacios de indentación
          "-ci", -- Indentación en listas de comandos dentro de bucles
          "-bn", -- Llaves en la misma línea
          "-sr", -- Simplificar redirecciones
          "-s", -- Ordenar imports
        },
      },
    },
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      svelte = { "prettier" },
      astro = { "prettier" },
      css = { "prettier" },
      cs = { "csharpier" },
      html = { "prettier" },
      markdown = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      graphql = { "prettier" },
      lua = { "stylua" },
      python = { "isort", "black" },
      sh = { "shfmt" },
      rust = { "rustfmt" },
      go = { "goimports" },
      bash = { "shfmt" },
    },
    format_on_save = {
      lsp_fallback = true,
      async = false,
      timeout_ms = 500,
    },
  },
}
