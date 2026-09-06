return {
  --[[]{
    "craftzdog/solarized-osaka.nvim",
    lazy = true,
    priority = 1000,
    opts = function()
      return {
        transparent = true,
      }
    end,
  },
]-- ]]
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      transparent_mode = true,
    },
  },

  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000, -- load before LazyVim sets colorscheme
    opts = {
      flavour = "mocha", -- explicitly use mocha
      transparent_background = true, -- optional
      custom_highlights = function(colors)
        return {
          -- Control Flow & Statements (Vibrant Red)
          ["@keyword.return"] = { fg = colors.red, bold = true },
          ["@keyword.conditional"] = { fg = colors.red, bold = true },
          ["@keyword.conditional.ternary"] = { fg = colors.red },
          ["@keyword.repeat"] = { fg = colors.red, bold = true },
          ["@keyword.exception"] = { fg = colors.red, bold = true },
          ["@keyword.coroutine"] = { fg = colors.red },
          ["@lsp.typemod.keyword.controlFlow"] = { fg = colors.red, bold = true },
          Conditional = { fg = colors.red, bold = true },
          Repeat = { fg = colors.red, bold = true },
          Exception = { fg = colors.red, bold = true },

          -- JSX / HTML Tags & Components (Vibrant Red)
          ["@tag"] = { fg = colors.red, bold = true },
          ["@tag.builtin"] = { fg = colors.red },
          ["@tag.attribute"] = { fg = colors.yellow, italic = true },
          ["@tag.delimiter"] = { fg = colors.subtext0 },
          htmlTagName = { fg = colors.red },
          htmlTag = { fg = colors.subtext0 },
          htmlEndTag = { fg = colors.subtext0 },

          -- Functions & Hooks (Bright Blue)
          ["@function"] = { fg = colors.blue, bold = true },
          ["@function.call"] = { fg = colors.blue },
          ["@function.method"] = { fg = colors.blue, bold = true },
          ["@function.method.call"] = { fg = colors.blue },
          ["@function.builtin"] = { fg = colors.sapphire },
          Function = { fg = colors.blue, bold = true },

          -- Object Properties & Members (Teal / Cyan)
          ["@property"] = { fg = colors.teal },
          ["@variable.member"] = { fg = colors.teal },
          ["@field"] = { fg = colors.teal },
          ["@lsp.type.property"] = { fg = colors.teal },
          ["@lsp.type.enumMember"] = { fg = colors.teal },

          -- Types & JSX Attributes (Warm Yellow)
          ["@type"] = { fg = colors.yellow },
          ["@type.builtin"] = { fg = colors.yellow },
          ["@type.definition"] = { fg = colors.yellow },
          ["@attribute"] = { fg = colors.yellow },
          Type = { fg = colors.yellow },
          Typedef = { fg = colors.yellow },
          StorageClass = { fg = colors.yellow },
          Structure = { fg = colors.yellow },
          ["@lsp.type.type"] = { fg = colors.yellow },
          ["@lsp.type.class"] = { fg = colors.yellow },
          ["@lsp.type.interface"] = { fg = colors.yellow },
          ["@lsp.type.struct"] = { fg = colors.yellow },
          ["@lsp.type.enum"] = { fg = colors.yellow },

          -- Parameters (Peach / Warm Orange)
          ["@variable.parameter"] = { fg = colors.peach, italic = true },
          ["@parameter"] = { fg = colors.peach, italic = true },
          ["@lsp.type.parameter"] = { fg = colors.peach, italic = true },

          -- Unused Code (Preserve syntax color + subtle undercurl, no dark-gray dimming)
          DiagnosticUnnecessary = { undercurl = true, sp = colors.overlay2 },

          -- Word Under Cursor / References (Clean underline instead of muddy visual block)
          LspReferenceText = { underline = true, bg = colors.surface0 },
          LspReferenceRead = { underline = true, bg = colors.surface0 },
          LspReferenceWrite = { underline = true, bg = colors.surface0 },
          LspReferenceTarget = { underline = true, bg = colors.surface0 },
          illuminatedWord = { underline = true, bg = colors.surface0 },
          illuminatedCurWord = { underline = true, bg = colors.surface0 },
          IlluminatedWordText = { underline = true, bg = colors.surface0 },
          IlluminatedWordRead = { underline = true, bg = colors.surface0 },
          IlluminatedWordWrite = { underline = true, bg = colors.surface0 },
        }
      end,
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        fzf = true,
        grug_far = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        snacks = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
