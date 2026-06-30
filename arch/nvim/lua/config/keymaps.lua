-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }
keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- Center before navigating
keymap.set("n", "*", "*zz")
keymap.set("n", "<C-d>", "<C-d>zz", opts)
keymap.set("n", "<C-u>", "<C-u>zz", opts)
keymap.set("n", "<C-o>", "<C-o>zz", opts)

-- change default esc
keymap.set("i", "jj", "<Esc>")

-- New tab
keymap.set("n", "te", ":tabedit %")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<S-tab>", ":tabprev<Return>", opts)
-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- vim.keymap.del("n", "<C-i>")
keymap.set("n", "<C-n>", "<C-i>")

-- keymap.set("v", "p", '"_dP')
-- keymap.set({ "n", "v" }, "d", '"_d')
-- keymap.set({ "n", "v" }, "x", '"_x')
keymap.set("v", "p", '"_dP', { desc = "Paste without overwriting clipboard" })
keymap.set({ "n", "v" }, "x", '"_x', { desc = "Delete character safely" })
keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without cutting" })

-- Quickfix
vim.keymap.set("n", "<C-q>", function()
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      vim.cmd("cclose")
      return
    end
  end
  vim.cmd("copen")
end, { desc = "Toggle quickfix" })

vim.keymap.set("n", "<leader>qn", ":cnext<CR>")
vim.keymap.set("n", "<leader>qp", ":cprev<CR>")

-- Buffers
vim.keymap.set("n", "QQ", ":bd<CR>", {
  desc = "Close buffer",
  silent = true,
})

-- Telescope
local builtin = require("telescope.builtin")

keymap.set("n", "<C-p>", builtin.find_files, { desc = "Search files" })

vim.keymap.set("n", "<C-k>", function()
  vim.cmd("enew")
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.swapfile = false
  vim.bo.buflisted = false
end, { desc = "New scratch buffer" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "php",
  callback = function()
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.expandtab = true
  end,
})

-- Agent Monitor: Track all agent code changes
vim.keymap.set("n", "<leader>am", function()
  require("plugins.agent-monitor").open()
end, { desc = "Open agent changes quickfix" })

vim.keymap.set("n", "<leader>ar", function()
  require("plugins.agent-monitor").refresh()
end, { desc = "Refresh agent changes" })

vim.keymap.set("n", "<leader>at", function()
  require("plugins.agent-monitor").toggle_auto_refresh()
end, { desc = "Toggle agent changes auto-refresh" })

-- Show hunks for current file in quickfix
vim.keymap.set("n", "<leader>ah", function()
  local file = vim.fn.expand("%:p")
  if file == "" then
    vim.notify("No file under cursor", vim.log.levels.WARN)
    return
  end

  local git_root = vim.fn.system("git -C " .. vim.fn.shellescape(vim.fn.fnamemodify(file, ":h")) .. " rev-parse --show-toplevel"):gsub("\n", "")
  if vim.v.shell_error ~= 0 then
    vim.notify("Not in a git repo", vim.log.levels.WARN)
    return
  end

  local rel_file = file:sub(#git_root + 2)
  local output = vim.fn.system("git -C " .. vim.fn.shellescape(git_root) .. " diff --no-color -U0 -- " .. vim.fn.shellescape(rel_file))

  local items = {}
  local current_lnum = 0
  local diff_lines = {}

  for line in output:gmatch("[^\n]+") do
    if line:match("^@@") then
      -- Save previous hunk if exists
      if current_lnum > 0 and #diff_lines > 0 then
        table.insert(items, {
          filename = file,
          lnum = current_lnum,
          text = table.concat(diff_lines, " | "),
        })
      end
      current_lnum = tonumber(line:match("%+(%d+)"))
      diff_lines = {}
    elseif current_lnum > 0 then
      if line:match("^%+") and not line:match("^%+%+%+") then
        table.insert(diff_lines, line:match("^%+(.*)"))
      elseif line:match("^%-") and not line:match("^%-%-%-") then
        table.insert(diff_lines, line:match("^%-(.*)"))
      end
    end
  end
  -- Save last hunk
  if current_lnum > 0 and #diff_lines > 0 then
    table.insert(items, {
      filename = file,
      lnum = current_lnum,
      text = table.concat(diff_lines, " | "),
    })
  end

  if #items == 0 then
    vim.notify("No hunks for " .. vim.fn.fnamemodify(file, ":t"), vim.log.levels.INFO)
    return
  end

  vim.fn.setqflist({}, "r", {
    title = "Hunks: " .. vim.fn.fnamemodify(file, ":t"),
    items = items,
  })
  vim.cmd("copen")
end, { desc = "Show file hunks in quickfix" })

-- Toggle neovim background transparency (reloads catppuccin)
local transparent_enabled = true
vim.keymap.set("n", "<leader>tt", function()
  transparent_enabled = not transparent_enabled
  require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = transparent_enabled,
    integrations = {
      aerial = true, alpha = true, cmp = true, dashboard = true,
      flash = true, fzf = true, gitsigns = true, illuminate = true,
      mason = true, mini = true, native_lsp = { enabled = true },
      neotest = true, neotree = true, noice = true, notify = true,
      telescope = true, treesitter = true, which_key = true,
    },
  })
  vim.cmd.colorscheme("catppuccin")
  vim.notify(transparent_enabled and "Transparency ON" or "Transparency OFF", vim.log.levels.INFO)
end, { desc = "Toggle background transparency" })
