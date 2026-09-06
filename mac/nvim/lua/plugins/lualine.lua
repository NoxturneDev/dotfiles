return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    table.insert(opts.sections.lualine_c, {
      function()
        local navic = require("nvim-navic")
        return navic.is_available() and navic.get_location() or ""
      end,
      cond = function()
        return require("nvim-navic").is_available()
      end,
    })
  end,
}
