local keymap = vim.keymap -- for conciseness

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- 缓冲区局部快捷键配置
    -- 更多函数文档请查阅 `:help vim.lsp.*`
    local opts = { buffer = ev.buf, silent = true }

    -- 设置快捷键
    opts.desc = "显示 LSP 引用"
    keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

    opts.desc = "跳转到声明处"
    keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

    opts.desc = "跳转到定义处"
    keymap.set("n", "gd", vim.lsp.buf.definition, opts)

    opts.desc = "显示 LSP 实现"
    keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

    opts.desc = "显示 LSP 类型定义"
    keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

    opts.desc = "查看可用的代码操作"
    keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

    opts.desc = "智能重命名"
    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    opts.desc = "显示当前文件诊断信息"
    keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

    opts.desc = "显示当前行诊断信息"
    keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

    opts.desc = "跳转到上一个诊断位置"
    keymap.set("n", "[d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, opts)

    opts.desc = "跳转到下一个诊断位置"
    keymap.set("n", "]d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, opts)

    opts.desc = "显示光标下的文档说明"
    keymap.set("n", "K", vim.lsp.buf.hover, opts)

    opts.desc = "重启 LSP 服务"
    keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
  end,
})

-- vim.lsp.inlay_hint.enable(true)

-- 自定义诊断图标
local severity = vim.diagnostic.severity

vim.diagnostic.config({
  signs = {
    text = {
      [severity.ERROR] = " ",
      [severity.WARN] = " ",
      [severity.HINT] = "󰠠 ",
      [severity.INFO] = " ",
    },
  },
})
