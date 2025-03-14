return {
  {
    'williamboman/mason.nvim',
    dependencies = {
      {
        'williamboman/mason-lspconfig.nvim',
        opts = {
          ensure_installed = {
            "lua_ls",
            "html",
            "gopls",
            "graphql",
          },
          automatic_installation = true,
        },
        config = function(_, opts)
          require("mason-lspconfig").setup(opts)
        end
      },
    },
    -- build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "goimports",
        "gofumpt",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
    end
  }
}
