if vim.g.vscode then
  -- 只有在 VSCode 中才执行的配置
  require("config.vscode")
  return
end
-- 只在独立运行 Neovim 时生效
require("config.lazy")
