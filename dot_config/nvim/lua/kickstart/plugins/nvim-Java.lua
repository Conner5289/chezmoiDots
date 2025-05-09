return {
  {
    'nvim-java/nvim-java',
    dependencies = {
      'nvim-java/lua-async-await',
      'nvim-java/nvim-java-core',
      'nvim-java/nvim-java-test',
      'nvim-java/nvim-java-dap',
      'nvim-java/nvim-java-refactor',
      'mfussenegger/nvim-dap',
    },
    config = function()
      require('java').setup() -- 🔧 Must come BEFORE lspconfig sets up jdtls
      -- require('lspconfig').jdtls.setup {} -- basic setup is fine here
    end,
    ft = { 'java' },
  },
}
