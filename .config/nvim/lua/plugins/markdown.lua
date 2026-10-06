return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  init = function()
    -- 设置预览主题为暗色（可选配置）
    vim.g.mkdp_theme = "dark"
    -- 指定预览使用的浏览器（可选配置，例如指定为 Firefox 或 Chromium）
    -- vim.g.mkdp_browser = '/usr/bin/firefox'
  end,
  keys = {
    { "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", ft = "markdown", desc = "Toggle Markdown Preview" },
  },
}
