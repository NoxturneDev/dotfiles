return {
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "Gclog" },
    keys = {
      { "<leader>gs", ":Git<CR>", desc = "Git Status" },
      { "<leader>dv", ":Gdiffsplit<CR>", desc = "Side-by-side Git Diff" },
      { "<leader>dh", ":Gdiffsplit!<CR>", desc = "Horizontal Git Diff" },
    },
    config = function()
      -- Floating diff for single file
      local function fugitive_float_diff()
        local buf = vim.api.nvim_create_buf(false, true)
        local file = vim.fn.expand("%")
        local diff = vim.fn.systemlist("git --no-pager diff --no-color " .. file)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, diff)

        local width = math.floor(vim.o.columns * 0.8)
        local height = math.floor(vim.o.lines * 0.8)
        local row = math.floor((vim.o.lines - height) / 2)
        local col = math.floor((vim.o.columns - width) / 2)

        local win = vim.api.nvim_open_win(buf, true, {
          relative = "editor",
          width = width,
          height = height,
          row = row,
          col = col,
          style = "minimal",
          border = "rounded",
        })

        vim.cmd("setlocal filetype=diff")
        vim.keymap.set("n", "q", function()
          vim.api.nvim_win_close(win, true)
        end, { buffer = buf, silent = true })
      end

      -- Project diff list
      local function project_float_diff()
        local changed_files = vim.fn.systemlist("git diff --name-only")

        if #changed_files == 0 or (#changed_files == 1 and changed_files[1] == "") then
          vim.notify("No modified files in the project!", vim.log.levels.INFO)
          return
        end

        local qf_list = {}
        for _, filename in ipairs(changed_files) do
          if filename ~= "" then
            table.insert(qf_list, { filename = filename, text = "Modified" })
          end
        end

        vim.fn.setqflist(qf_list, "r")
        vim.cmd("copen")
      end

      vim.api.nvim_create_user_command("GFloatDiff", fugitive_float_diff, {})
      vim.api.nvim_create_user_command("GProjectDiff", project_float_diff, {})
      vim.keymap.set("n", "<leader>dd", ":GFloatDiff<CR>", { desc = "Floating Single File Diff" })
      vim.keymap.set("n", "<leader>gD", ":GProjectDiff<CR>", { desc = "Interactive Project Diff List" })

    end,
  },
}
