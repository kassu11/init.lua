return {
  "https://codeberg.org/mfussenegger/nvim-jdtls",
  enabled = true,
  config = function()
    local jdtls_home = "C:/software/jdt-language-server-1.61.0-202609031315"
    -- jdtls 1.61 requires Java 21+, but JAVA_HOME / PATH point at 17.
    local java = "C:/Program Files/Amazon Corretto/jdk21.0.12_8/bin/java.exe"

    local function start()
      local jdtls = require("jdtls")

      local launcher = vim.fn.glob(jdtls_home .. "/plugins/org.eclipse.equinox.launcher_*.jar")
      if launcher == "" then
        vim.notify("jdtls launcher jar not found in " .. jdtls_home, vim.log.levels.ERROR)
        return
      end

      local root_dir = vim.fs.root(0, { "mvnw", "gradlew", "settings.gradle", "settings.gradle.kts", ".git", "pom.xml", "build.gradle", "build.gradle.kts" })
          or vim.fn.getcwd()
      local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

      jdtls.start_or_attach({
        cmd = {
          java,
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-Xms256m",
          "--add-modules=ALL-SYSTEM",
          "--add-opens", "java.base/java.util=ALL-UNNAMED",
          "--add-opens", "java.base/java.lang=ALL-UNNAMED",
          "-jar", launcher,
          "-configuration", jdtls_home .. "/config_win",
          "-data", workspace_dir,
        },
        root_dir = root_dir,
        capabilities = vim.lsp.protocol.make_client_capabilities(),
      })
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("config_jdtls", { clear = true }),
      pattern = "java",
      callback = start,
    })
  end,
}
