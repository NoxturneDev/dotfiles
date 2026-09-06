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
          -- Control Flow & Statements (Mauve Purple)
          ["@keyword.return"] = { fg = colors.mauve, bold = true },
          ["@keyword.conditional"] = { fg = colors.mauve, bold = true },
          ["@keyword.conditional.ternary"] = { fg = colors.mauve },
          ["@keyword.repeat"] = { fg = colors.mauve, bold = true },
          ["@keyword.exception"] = { fg = colors.mauve, bold = true },
          ["@keyword.coroutine"] = { fg = colors.mauve },
          ["@lsp.typemod.keyword.controlFlow"] = { fg = colors.mauve, bold = true },
          Conditional = { fg = colors.mauve, bold = true },
          Repeat = { fg = colors.mauve, bold = true },
          Exception = { fg = colors.mauve, bold = true },

          -- JSX / HTML Tags & Components (Coral Red)
          ["@tag"] = { fg = colors.red, bold = true },
          ["@tag.javascript"] = { fg = colors.red, bold = true },
          ["@tag.jsx"] = { fg = colors.red, bold = true },
          ["@tag.tsx"] = { fg = colors.red, bold = true },
          ["@tag.builtin"] = { fg = colors.red },
          ["@tag.builtin.javascript"] = { fg = colors.red },
          ["@tag.builtin.jsx"] = { fg = colors.red },
          ["@tag.builtin.tsx"] = { fg = colors.red },
          ["@tag.component"] = { fg = colors.red, bold = true },
          ["@constructor.jsx"] = { fg = colors.red, bold = true },
          ["@constructor.tsx"] = { fg = colors.red, bold = true },
          ["@tag.delimiter"] = { fg = colors.subtext0 },
          Tag = { fg = colors.red, bold = true },
          htmlTagName = { fg = colors.red, bold = true },
          htmlTag = { fg = colors.subtext0 },
          htmlEndTag = { fg = colors.subtext0 },
          jsxTagName = { fg = colors.red, bold = true },
          jsxComponentName = { fg = colors.red, bold = true },

          -- JSX / HTML Attributes & Properties (Mint Teal)
          ["@tag.attribute"] = { fg = colors.teal, italic = true },
          ["@tag.attribute.javascript"] = { fg = colors.teal, italic = true },
          ["@tag.attribute.jsx"] = { fg = colors.teal, italic = true },
          ["@tag.attribute.tsx"] = { fg = colors.teal, italic = true },
          ["@property"] = { fg = colors.teal, italic = true },
          ["@property.javascript"] = { fg = colors.teal, italic = true },
          ["@property.typescript"] = { fg = colors.teal, italic = true },
          ["@variable.member"] = { fg = colors.teal },
          ["@field"] = { fg = colors.teal },
          ["@lsp.type.property"] = { fg = colors.teal, italic = true },
          ["@lsp.type.enumMember"] = { fg = colors.teal },
          htmlArg = { fg = colors.teal, italic = true },
          jsxAttrib = { fg = colors.teal, italic = true },

          -- Functions & Hooks (Bright Blue)
          ["@function"] = { fg = colors.blue, bold = true },
          ["@function.call"] = { fg = colors.blue },
          ["@function.method"] = { fg = colors.blue, bold = true },
          ["@function.method.call"] = { fg = colors.blue },
          ["@function.builtin"] = { fg = colors.sapphire },
          Function = { fg = colors.blue, bold = true },

          -- Types (Warm Yellow)
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
      local catppuccin = require("catppuccin")
      catppuccin.setup(opts)
      catppuccin.compile()
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
