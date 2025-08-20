return {
  -- Roslyn LSP (Microsoft’s language server)
  {
    "seblyng/roslyn.nvim",
    ft = { "cs" },
    opts = {
      -- The plugin downloads/boots the Roslyn LSP for you.
      -- Defaults are good; tweak only if you need custom dotnet path or config.
      -- dotnet_cmd = "dotnet",
      -- settings = { ... } -- Roslyn LSP settings (rarely needed)
    },
  },
}
