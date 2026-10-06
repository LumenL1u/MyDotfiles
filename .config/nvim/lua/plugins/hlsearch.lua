return {
  "nvimdev/hlsearch.nvim",
  event = "BufRead", -- 或 VeryLazy
  config = function()
    require("hlsearch").setup()
  end,
}
