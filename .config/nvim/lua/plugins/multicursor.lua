return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  config = function()
    local mc = require("multicursor-nvim")
    mc.setup()

    local set = vim.keymap.set

    set({ "n", "x" }, "<c-n>", function()
      mc.matchAddCursor(1)
    end)
    set({ "n", "x" }, "<c-p>", function()
      mc.matchAddCursor(-1)
    end)
    mc.addKeymapLayer(function(layerSet)
      -- Enable and clear cursors using escape.
      layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end)
      layerSet("i", "jk", function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", true)
        vim.schedule(function()
          mc.clearCursors()
        end)
      end)
    end)
  end,
}
