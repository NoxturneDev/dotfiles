vim.g.dadbod_mysql_command = "C:/laragon/bin/mysql/mysql-8.0.30-winx64/bin/mysql.exe"
vim.keymap.set("v", "<leader><CR>", ":'<,'>DB<CR>", { desc = "Run SQL in selected line" })

return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}
