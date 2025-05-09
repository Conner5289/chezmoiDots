local jdtls = require 'jdtls'
local home = os.getenv 'HOME'

-- Workspace folder for JDTLS
local workspace_folder = home .. '/.cache/jdtls/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

-- Lombok JAR path
local lombok_path = home .. '/.local/share/java/lombok.jar'

-- LSP capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local config = {
  cmd = {
    '/home/conner/.lsps/jdtls/bin/jdtls',
    '-javaagent:' .. lombok_path,
    '-Xmx1G', -- Increase memory for stability
    '--log-level=ALL', -- Enable detailed logging
    '-data',
    workspace_folder,
  },
  root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' },
  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },
      completion = {
        favoriteStaticMembers = {
          'org.junit.Assert.*',
          'org.junit.Assume.*',
          'org.junit.jupiter.api.Assertions.*',
          'org.junit.jupiter.api.Assumptions.*',
          'org.junit.jupiter.api.DynamicContainer.*',
          'org.junit.jupiter.api.DynamicTest.*',
        },
      },
      maven = {
        downloadSources = true,
        autoImport = true,
      },
      gradle = {
        autoImport = true,
        useGradleWrapper = true,
        synchronization = true,
      },
      configuration = {
        annotationProcessing = { enabled = true },
      },
      autobuild = { enabled = true }, -- Ensure autobuild is on
    },
  },
  init_options = {
    bundles = {}, -- No bundles needed for Lombok
  },
  capabilities = capabilities,
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'java',
  callback = function()
    jdtls.start_or_attach(config)
  end,
})

return config
