return {
  "rmagatti/auto-session",
  cmd = {
    "AutoSession",
  },
  keys = {
    { "<leader>wr", "<cmd>AutoSession restore<CR>", desc = "恢复 cwd 会话" },
    { "<leader>ws", "<cmd>AutoSession save<CR>", desc = "保存会话至自动会话根目录" },
  },
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
    })
  end,
}
