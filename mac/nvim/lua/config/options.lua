-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Ensure nvim-treesitter runtime queries are always discovered
local ts_runtime = vim.fn.expand("~/.local/share/nvim/lazy/nvim-treesitter/runtime")
if vim.uv.fs_stat(ts_runtime) then
  vim.opt.runtimepath:prepend(ts_runtime)
end

-- Ensure React / JSX filetypes map to javascript / tsx treesitter parsers
vim.treesitter.language.register("javascript", { "javascriptreact", "jsx" })
vim.treesitter.language.register("tsx", { "typescriptreact" })
