local map = vim.keymap.set
-- ==================== 肌肉记忆强制训练 ====================
-- 强制使用 h, j, k, l 进行移动
map("n", "<Left>", ":echoe 'Use h'<CR>", { desc = "使用 h" })
map("n", "<Right>", ":echoe 'Use l'<CR>", { desc = "使用 l" })
map("n", "<Up>", ":echoe 'Use k'<CR>", { desc = "使用 k" })
map("n", "<Down>", ":echoe 'Use j'<CR>", { desc = "使用 j" })

-- ==================== 按键映射 =====================
-- 编辑快捷键
map("i", "jk", "<Esc>", { desc = "退出编辑模式" })
map("n", "<leader>q", ":qa<cr>", { desc = "退出编辑器" })
map({ "!" }, "<c-a>", "<HOME>", { desc = "光标到行首" })
map({ "!" }, "<c-e>", "<END>", { desc = "光标到行尾" })
map({ "n" }, "<leader>nh", ":nohl<CR>", { desc = "清除搜索高亮" })

-- 导航快捷键
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

if vim.fn.has("nvim") == 1 then
	map("n", "<leader>v", ":e $HOME/.config/nvim/<cr>", { desc = "打开 Neovim 配置文件" })
else
	map("n", "<leader>v", ":e $MYVIMRC<cr>", { desc = "打开 Vim 配置文件" })
end
