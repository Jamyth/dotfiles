return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		nvimtree.setup({
			view = {
				width = 45,
				relativenumber = true,
				side = "right",
			},

			-- change folder arrow icon
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					git_placement = "signcolumn",
					glyphs = {
						-- folder = {
						-- 	-- arrow_closed = "→",
						-- 	-- arrow_open = "↓",
						-- },
						git = {
							-- unstaged = ""
						},
					},
				},
				highlight_git = "name",
			},

			-- Update focused file on BufEnter
			-- un-collapees the folder to show the opened file
			update_focused_file = {
				enable = true,
			},

			-- disable window_picker for
			-- explorer to work well with
			-- window splits
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
					quit_on_open = true,
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
		})

		-- Keymap setup
		local keymap = vim.keymap

		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
		keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current" })
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
	end,
}
