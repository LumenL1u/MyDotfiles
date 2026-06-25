return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = {
      "NvimTreeToggle",
      "NvimTreeFindFileToggle",
      "NvimTreeCollapse",
      "NvimTreeRefresh",
    },
    keys = {
      { "<leader>ee", "<cmd>NvimTreeToggle<CR>", desc = "显示/隐藏文件资源管理器" },
      {
        "<leader>ef",
        "<cmd>NvimTreeFindFileToggle<CR>",
        desc = "显示/隐藏文件资源管理器（当前文件）",
      },
      { "<leader>ec", "<cmd>NvimTreeCollapse<CR>", desc = "折叠文件资源管理器" },
      { "<leader>er", "<cmd>NvimTreeRefresh<CR>", desc = "刷新文件资源管理器" },
    },
    config = function()
      local nvimtree = require("nvim-tree")

      -- recommended settings from nvim-tree documentation
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      nvimtree.setup({
        view = {
          width = 35,
          number = true,
          relativenumber = true,
        },
        -- change folder arrow icons
        renderer = {
          add_trailing = true,
          highlight_git = "all",
          highlight_opened_files = "all",
          indent_markers = {
            enable = true,
          },
          icons = {
            glyphs = {
              folder = {
                arrow_closed = "", -- arrow when folder is closed
                arrow_open = "", -- arrow when folder is open
              },
            },
          },
        },
        actions = {
          open_file = {
            window_picker = {
              enable = false,
            },
          },
        },
        filters = {
          dotfiles = false,
          custom = {
            "^\\.git$",
            "^\\.DS_Store$",
            "^node_modules$",
            "^__pycache__$",
          },
        },
        git = {
          ignore = false,
        },
      })
    end,
  },
}
