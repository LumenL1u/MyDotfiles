return {
  "akinsho/bufferline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "tabs",
      separator_style = "slant",

      -- 只取文件名（去掉路径），终端显示为 "Terminal"
      name_formatter = function(buf)
        local name = buf.name or ""
        -- 终端 buffer → 显示为 "Terminal"
        if name:match("^term://") then
          return "Terminal"
        end
        -- snacks picker 等非文件 buffer → 不显示
        if name == "" or buf.buftype == "nofile" then
          return nil
        end
        -- 普通文件 → 只取文件名
        return vim.fn.fnamemodify(name, ":t")
      end,

      -- 过滤掉 snacks 相关伪文件
      custom_filter = function(buf_number)
        local bt = vim.bo[buf_number].buftype
        local ft = vim.bo[buf_number].filetype
        if bt == "nofile" or bt == "prompt" then
          return false
        end
        if ft:match("^snacks_") then
          return false
        end
        return true
      end,
    },
  },
}
