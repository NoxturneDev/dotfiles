return {
  "pechorin/any-jump.vim",
  cmd = "AnyJump",
  keys = {
    { "gJ", "<cmd>AnyJump<CR>", mode = "n", desc = "Go to definition/references" },
    { "gJ", "<cmd>AnyJumpVisual<CR>", mode = "v", desc = "Go to selected text" },
    { "gO", "<cmd>AnyJumpBack<CR>", mode = "n", desc = "AnyJump back" },
    { "gL", "<cmd>AnyJumpLastResults<CR>", mode = "n", desc = "AnyJump last results" },
  },
  config = function()
    vim.g.any_jump_disable_default_keybindings = 1
    vim.g.any_jump_list_numbers = 0
    vim.g.any_jump_references_enabled = 1
    vim.g.any_jump_grouping_enabled = 1
    vim.g.any_jump_preview_lines_count = 5
    vim.g.any_jump_max_search_results = 10
    vim.g.any_jump_search_prefered_engine = "rg"
    vim.g.any_jump_results_ui_style = "filename_first"
    vim.g.any_jump_remove_comments_from_results = 1
  end,
}
