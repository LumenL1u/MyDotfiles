return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  opts = {
    focus = true,
  },
  cmd = "Trouble",
  keys = {
    { "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", desc = "打开工作区诊断列表" },
    { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "打开当前文档诊断列表" },
    { "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", desc = "打开快速修复列表" },
    { "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "打开位置列表" },
    { "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "打开待办事项列表" },
  },
}
