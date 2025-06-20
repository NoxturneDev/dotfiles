vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.diagnostic.disable(args.buf)
  end,
})

return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      php = {}, -- disable PHP formatters
    },
    servers = {
      intelephense = {},
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              format = {
                enable = false, -- <- this disables Lua LS built-in formatting
              },
              codeLens = {
                enable = false,
              },
            },
          },
        },
      },
      setup = {
        lua_ls = function(_, opts)
          -- disable formatting capability
          opts.on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end
        end,
      },
    },
  },
}
