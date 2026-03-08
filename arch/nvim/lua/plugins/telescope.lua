local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            -- normal enter key
            ["<CR>"] = actions.select_default,

            -- our custom Ctrl+k scratchpad open
            ["<C-k>"] = function(prompt_bufnr)
              local entry = action_state.get_selected_entry()
              local filepath = entry.path or entry.filename

              actions.close(prompt_bufnr)

              -- open temporary scratch window with file
              local buf = vim.api.nvim_create_buf(true, true)
              vim.api.nvim_win_set_buf(0, buf)
              vim.cmd("edit " .. vim.fn.fnameescape(filepath))

              -- mark as temporary (unlisted)
              vim.bo[buf].buflisted = false
              vim.bo[buf].bufhidden = "wipe"
            end,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = {
            "rg",
            "--files",
            "--hidden",
            "--glob",
            "!**/.git/*",
            "--glob",
            "!**/node_modules/*",
          },
        },
        live_grep = {
          additional_args = function(opts)
            return { "--hidden" }
          end,
        },
      },
    })
    pcall(function()
      require("telescope").load_extension("fzf")
    end)
  end,
}
