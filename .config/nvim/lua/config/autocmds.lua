-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- 创建一个 augroup 来管理你的 Python 自动命令
local python_group = vim.api.nvim_create_augroup("PythonSetting", { clear = true })

-- F5 保存并运行 python
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  group = python_group,
  callback = function()
    vim.keymap.set("n", "<F5>", function()
      vim.cmd("w") -- 保存

      local file = vim.fn.expand("%:p")
      local python_cmd = vim.env.VIRTUAL_ENV and (vim.env.VIRTUAL_ENV .. "/bin/python") or "python3"

      vim.notify("🚀 正在异步运行 Python...", vim.log.levels.INFO)

      vim.system({ python_cmd, file }, { text = true }, function(obj)
        vim.schedule(function()
          if obj.code == 0 then
            if obj.stdout ~= "" then
              print(obj.stdout)
            else
              vim.notify("运行成功（无输出）", vim.log.levels.INFO)
            end
          else
            -- 运行失败，弹出红字报错
            vim.notify("❌ 运行失败:\n" .. obj.stderr, vim.log.levels.ERROR)
          end
        end)
      end)
    end, { silent = true, desc = "Async Run Python", buffer = true })
  end,
})

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "python", -- 仅在 Python 文件中生效
--   group = python_group,
--   command = [[inoreabbrev ct """]], -- 在插入模式下创建缩写
-- })

-- 搜索完自动取消高亮，下次搜索再恢复
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.cmd("nohlsearch")
  end,
})

vim.api.nvim_create_autocmd("CmdwinEnter", {
  pattern = "/",
  callback = function()
    vim.opt.hlsearch = true
  end,
})
