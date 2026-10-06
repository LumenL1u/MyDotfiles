return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha", -- 深色推荐 mocha；想要更柔和可选 macchiato
      background = {
        dark = "mocha",
        light = "latte",
      },
      transparent_background = false,
      show_end_of_buffer = false,
      term_colors = true,
      styles = {
        comments = { "italic" },
        keywords = { "italic" },
        functions = {},
        variables = {},
      },
      integrations = {
        cmp = true,
        telescope = true,
        neotree = true,
        treesitter = true,
        notify = true,
        which_key = true,
        indent_blankline = { enabled = true },
        gitsigns = true,
        snacks = true,
        noice = true,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
