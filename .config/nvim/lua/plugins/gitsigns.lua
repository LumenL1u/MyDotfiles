return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
      end

      -- 导航 (Navigation)
      map("n", "]g", gs.next_hunk, "下一处变更块")
      map("n", "[g", gs.prev_hunk, "上一处变更块")

      -- 操作 (Actions)
      map("n", "<leader>gs", gs.stage_hunk, "暂存变更块")
      map("n", "<leader>gr", gs.reset_hunk, "重置(丢弃)变更块")
      map("v", "<leader>gs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "暂存选中块")
      map("v", "<leader>gr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "重置(丢弃)选中块")

      map("n", "<leader>gS", gs.stage_buffer, "暂存整个文件")
      map("n", "<leader>gR", gs.reset_buffer, "重置(丢弃)整个文件")

      map("n", "<leader>gu", gs.undo_stage_hunk, "撤销暂存变更块")

      map("n", "<leader>gp", gs.preview_hunk, "预览变更块对比")

      map("n", "<leader>gb", function()
        gs.blame_line({ full = true })
      end, "查看当前行 Blame (详细)")
      map("n", "<leader>gB", gs.toggle_current_line_blame, "切换行内 Blame 提示")

      map("n", "<leader>gd", gs.diffthis, "打开 Diff 视图")
      map("n", "<leader>gD", function()
        gs.diffthis("~")
      end, "打开 Diff 视图 (历史版本)")

      -- 文本对象 (Text object，用于选中变更块)
      map({ "o", "x" }, "ig", ":<C-U>Gitsigns select_hunk<CR>", "选中当前变更块")
    end,
  },
}
