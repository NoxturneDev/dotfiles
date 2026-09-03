-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Create a custom highlight group for solid markdown background
local function update_markdown_bg()
  local colors_name = vim.g.colors_name or ""
  local bg_color = nil

  if colors_name:find("catppuccin") then
    local ok, catppuccin = pcall(require, "catppuccin.palettes")
    if ok then
      local palette = catppuccin.get_palette()
      if palette then
        bg_color = palette.base
      end
    end
  elseif colors_name:find("tokyonight") then
    local ok, tokyonight = pcall(require, "tokyonight.colors")
    if ok then
      local colors = tokyonight.setup()
      if colors then
        bg_color = colors.bg
      end
    end
  elseif colors_name:find("gruvbox") then
    bg_color = "#282828"
  end

  -- Fallback to NormalFloat background if available
  if not bg_color then
    local normal_float = vim.api.nvim_get_hl(0, { name = "NormalFloat" })
    if normal_float and normal_float.bg then
      bg_color = string.format("#%06x", normal_float.bg)
    end
  end

  -- Ultimate fallback
  bg_color = bg_color or "#1e1e2e"

  vim.api.nvim_set_hl(0, "MarkdownSolidBG", { bg = bg_color })
end

-- Update highlight group on startup and when colorscheme changes
update_markdown_bg()
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = update_markdown_bg,
})

-- Apply solid background to markdown files
vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
  pattern = "*",
  callback = function(args)
    if vim.bo[args.buf].filetype == "markdown" then
      vim.wo.winhighlight = "Normal:MarkdownSolidBG,NormalNC:MarkdownSolidBG,SignColumn:MarkdownSolidBG"
      vim.diagnostic.enable(false, { bufnr = args.buf })
    end
  end,
})
