return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    require("telescope").setup({
      extensions = {
        find_files = {
          hidden = true,
        },
      },
    })
    pcall(function()
      require("telescope").load_extension("fzf")
    end)
  end,
}
