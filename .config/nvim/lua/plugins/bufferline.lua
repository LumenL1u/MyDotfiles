return {
  "akinsho/bufferline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "tabs",
      separator_style = "slant",
    },
  },
}
