return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local neogit = require("neogit")
		local keymap = vim.keymap
		local diffview = require("diffview")
		local diffview_actions = require("diffview.actions")

		local close_all = function()
			vim.cmd("DiffviewClose")
		end

		neogit.setup({})
		diffview.setup({
			enhanced_diff_hl = true,
			keymaps = {
				view = {
					{ "n", "<leader>gf", diffview_actions.goto_file_tab, { desc = "Go to file" } },
					{ "n", "<C-c>", close_all, { desc = "Go to file" } },
				},
				file_panel = {
					{ "n", "<leader>gf", diffview_actions.goto_file_tab, { desc = "Go to file" } },
					{ "n", "<C-c>", close_all, { desc = "Go to file" } },
				},
			},
		})

		-- keymaps
		keymap.set("n", "<leader>lg", function()
			neogit.open({ kind = "floating" })
		end, { desc = "Open Neogit" })
		keymap.set("n", "<leader>hd", function()
			vim.cmd("DiffviewOpen")
		end, { desc = "Open Diffview" })
	end,
}
