return {
  "gbprod/substitute.nvim",
  event = { "BufReadPost", "BufNewFile" },
  -- keys = {
  --   {"s", substitute.operator, mode = {"n", "v"}, desc = "替换动作"},
  --   {"ss", substitute.operator, mode = "n", desc = "替换整行"},
  --   {"S", substitute.operator, mode = "n", desc = "替换到行尾"},
  -- }
  config = function()
    local substitute = require("substitute")

    substitute.setup()

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    vim.keymap.set("n", "s", substitute.operator, { desc = "Substitute with motion" })
    vim.keymap.set("n", "ss", substitute.line, { desc = "Substitute line" })
    vim.keymap.set("n", "S", substitute.eol, { desc = "Substitute to end of line" })
    vim.keymap.set("x", "s", substitute.visual, { desc = "Substitute in visual mode" })
  end,
}
