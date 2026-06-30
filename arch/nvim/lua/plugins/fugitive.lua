-- 1. Your original single-file diff (with a small fix to allow pressing 'q' to close it!)
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
  -- Hotkey: Press 'q' inside the float to close it instantly
  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = buf, silent = true })
end

-- 2. New Function: Scan project, list files, and let you scroll their diffs
local function project_float_diff()
  -- Get the list of all modified files from git
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

  -- Set the files into Neovim's internal quickfix engine
  vim.fn.setqflist(qf_list, "r")
  vim.cmd("copen") -- Opens the small list panel at the bottom

  -- Remap 'Enter' inside this specific list to trigger your custom floating scrollable diff
  local qf_buf = vim.api.nvim_get_current_buf()
  vim.keymap.set("n", "<CR>", function()
    -- Get the file line under the cursor
    local line = vim.api.nvim_get_current_line()
    local filename = string.match(line, "([^|]+)") -- Extract filename before the separator
    if filename then
      filename = vim.trim(filename)
      vim.cmd("edit " .. filename) -- Open it in the background
      fugitive_float_diff() -- Fire your scrollable float window!
    end
  end, { buffer = qf_buf, silent = true })
end

-- User Commands
vim.api.nvim_create_user_command("GFloatDiff", fugitive_float_diff, {})
vim.api.nvim_create_user_command("GProjectDiff", project_float_diff, {})

-- Keymaps
vim.keymap.set("n", "<leader>dd", ":GFloatDiff<CR>", { desc = "Floating Single File Diff" })
vim.keymap.set("n", "<leader>gD", ":GProjectDiff<CR>", { desc = "Interactive Project Diff List" })

return {}
