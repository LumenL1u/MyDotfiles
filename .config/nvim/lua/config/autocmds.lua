-- 退出vim时自动关闭文件树
vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local invalid_win = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match("NvimTree_") then
        table.insert(invalid_win, w)
      end
    end
    if #wins - #invalid_win <= 1 then
      for _, w in ipairs(invalid_win) do
        vim.api.nvim_win_close(w, true)
      end
    end
  end,
})

-- 按下 F5 保存并运行当前 Python 文件
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.keymap.set("n", "<F5>", function()
      vim.cmd("w")
      vim.cmd("split | resize 10 | term python3 " .. vim.fn.expand("%"))
      vim.cmd("startinsert")
    end, { silent = true, desc = "Save & Run Python", buffer = true })
  end,
})

-- 保存时自动格式化与导包排序
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    vim.lsp.buf.code_action({
      context = { only = { "source.organizeImports" } },
      apply = true,
    })
    vim.lsp.buf.format({ async = false })
  end,
})

-- 强制对没有 filetype 的 buffer 重新进行检测
vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost" }, {
  callback = function()
    -- 如果当前 buffer 没有 filetype，并且不是一个空的新文件
    if vim.bo.filetype == "" and vim.fn.expand("%") ~= "" then
      vim.cmd("filetype detect")
    end
  end,
})
