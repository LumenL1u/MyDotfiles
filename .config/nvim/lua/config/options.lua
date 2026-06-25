local opt = vim.opt

-- UI
opt.shortmess = 'atI'                       -- 精简消息提示，关闭启动欢迎界面
vim.cmd("let g:netrw_liststyle = 3")        -- 设置vim内置文件资源管理器使用树状列表
opt.background = 'dark'                     -- 现代高颜值主题（如 Tokyo Night）的基石
vim.cmd('set t_Co=256')
opt.termguicolors = true
opt.signcolumn = 'yes'                      -- 始终开启标记列
opt.laststatus = 2                          -- 始终显示底部状态栏
opt.showmode = false                        -- 隐藏 Neovim 自带的模式显示
opt.title = true                            -- 在终端标题栏显示文件名
opt.showcmd = true                          -- 在底部状态栏实时显示正在输入的命令
opt.number = true                           -- 显示绝对行号 + 相对行号
opt.relativenumber = true
opt.cursorline = true                       -- 高亮当前行
opt.list = true                             -- 显示隐藏字符
opt.lcs = 'tab:▸\\ ,trail:·,eol:¬,nbsp:_'   -- 不可见字符可视化

-- 编辑
opt.encoding = 'utf-8'                      -- 编辑器内部字符编码
opt.mouse = 'a'                             -- 开启全模式鼠标支持
opt.completeopt:append('menuone')           -- 补全菜单优化
opt.clipboard = 'unnamedplus'               -- 默认直接使用系统剪贴板
opt.backspace = 'indent,eol,start'          -- 退格优化
opt.wildmenu = true                         -- 极佳的命令行 Tab 补全菜单
opt.ignorecase = true                       -- 搜索忽略大小写，但包含大写字母时严格匹配
opt.smartcase = true
opt.hlsearch = true                         -- 边输入边高亮搜索结果
opt.incsearch = true
opt.tabstop = 2                             -- 1 个 Tab 占用的空格数
opt.shiftwidth = 2                          -- 自动缩进时使用的空格数
opt.expandtab = true                        -- 将 Tab 自动转换为空格
opt.autoindent = true                       -- 创建新行时复制当前行的缩进
opt.backupdir = vim.fn.expand('~/.local/state/nvim/backup//')   --集中备份、交换文件和撤销历史
opt.directory = vim.fn.expand('~/.local/state/nvim/swap//')
opt.undodir = vim.fn.expand('~/.local/state/nvim/undo//')
opt.undofile = true
local state_dir = vim.fn.expand('~/.local/state/nvim')
vim.fn.mkdir(state_dir .. '/backup', 'p')
vim.fn.mkdir(state_dir .. '/swap', 'p')
vim.fn.mkdir(state_dir .. '/undo', 'p')
opt.backupskip = '/tmp/*,/private/tmp/*'

-- 界面操作
opt.hidden = true                           -- 允许未保存时切换 Buffer
opt.belloff = 'all'                         -- 禁用所有烦人的系统警告声
opt.scrolloff = 3                           -- 光标距离顶部/底部 3 行时自动滚动
opt.wrap = false                            -- 关闭自动折行，代码更整洁
opt.splitright = true                       -- 新分屏默认在右侧和下方
opt.splitbelow = true
