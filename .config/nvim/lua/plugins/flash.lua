return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash Jump",
    },
    {
      "<leader><leader>",
      mode = { "n" },
      function()
        require("flash").jump()
      end,
      desc = "Flash Jump",
    },
  },
}
