return {
  "mfussenegger/nvim-jdtls",
  ft = { "java" }, -- Se carga únicamente cuando se abre un archivo Java
  config = function()
    local jdtls = require("jdtls")
    local home = os.getenv("HOME")
    local jdtls_path = home .. "/.cache/jdtls" -- Asegúrate de que este directorio es donde extrajiste JDT LS
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_folder = home .. "/.cache/jdtls/workspace/" .. project_name

    local config = {
      cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        jdtls_path .. "/plugins/org.eclipse.equinox.launcher_1.6.1000.v20250227-1734.jar", -- Actualiza el nombre según la versión que tengas
        "-configuration",
        jdtls_path .. "/config_mac_arm", -- O la carpeta de configuración que corresponda a tu SO
        "-data",
        workspace_folder,
      },
      root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
      settings = {
        java = {
          signatureHelp = { enabled = true },
          contentProvider = { preferred = "fernflower" },
          -- Puedes agregar más configuraciones específicas de Java aquí
        },
      },
      init_options = {
        bundles = {},
      },
    }

    jdtls.start_or_attach(config)
  end,
}
