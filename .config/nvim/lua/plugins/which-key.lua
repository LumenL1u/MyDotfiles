return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    delay = 250,
    spec = {
      {
        { "<leader>s", group = "窗口操作", icon = " " },
        { "<leader>e", group = "文件树/资源管理器", icon = "󰙅 " },
        { "<leader>t", group = "标签页", icon = "󰓩 " },
        { "<leader>f", group = "Telescope模糊检索", icon = "󰈞 " },
        { "<leader>w", group = "工作区会话", icon = "󱂬 " },
        { "<leader>x", group = "诊断与列表", icon = "󰦪 " },
        { "<leader>g", group = "Git 变更块", icon = "󰊢 " },
      },
    },
  },
}
