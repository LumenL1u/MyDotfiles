return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "default",
      -- 弹出菜单时，Tab 选下一个；菜单未弹出时，Tab 正常缩进
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
      -- Enter 确认选中项
      ["<CR>"] = { "select_and_accept", "fallback" },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
}
