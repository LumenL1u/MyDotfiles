return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	cmd = { "Telescope" },
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "在 cwd 中模糊查找文件" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "模糊查找最近文件" },
		{ "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "在 cwd 中查找字符串" },
		{ "<leader>fc", "<cmd>Telescope grep_string<cr>", desc = "在 cwd 中查找当前光标下字符串" },
		{ "<leader>ft", "<cmd>Telescope todo-comments<cr>", desc = "查找todos" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
		})

		telescope.load_extension("fzf")
	end,
}
