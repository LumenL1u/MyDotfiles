-- Keymaps are automatically loaded on the VeryLazy event Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

local is_maximized = false
local function toggle_maximize_window()
  if is_maximized then
    vim.cmd("wincmd =")
    is_maximized = false
  else
    vim.cmd("wincmd _")
    vim.cmd("wincmd |")
    is_maximized = true
  end
end
map("i", "jk", "<Esc>", { desc = "退出编辑模式" })
map("n", "<leader>sv", "<C-w>v", { desc = "垂直切分窗口" })
map("n", "<leader>sh", "<C-w>s", { desc = "水平切分窗口" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "关闭当前窗口" })
map("n", "<leader>se", "<C-w>=", { desc = "恢复窗口大小" })
map("n", "<leader>sm", toggle_maximize_window, { desc = "最大化当前窗口" })
map("n", "<leader>tc", "<cmd>tabnew<CR>", { desc = "打开新标签页" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "关闭当前标签页" })
map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "下一个标签页" })
map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "上一个标签页" })
map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "在新标签页中打开当前缓冲区" })
map("n", "<C-h>", "<C-w>h", { desc = "切换到左侧窗口" })
map("n", "<C-j>", "<C-w>j", { desc = "切换到下方窗口" })
map("n", "<C-k>", "<C-w>k", { desc = "切换到上方窗口" })
map("n", "<C-l>", "<C-w>l", { desc = "切换到右侧窗口" })

vim.keymap.set("n", "<c-a>", ":%y<cr>", { silent = true, desc = "复制整个文件内容" })
vim.keymap.set("n", "<c-\\>", function()
  vim.cmd("lcd %:h")
  Snacks.terminal(nil, { cwd = vim.fn.getcwd(-1, 0) }) -- 取当前窗口的 cwd
end, { desc = "Terminal at window dir" })
