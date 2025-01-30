return {
	"akinsho/toggleterm.nvim",
	version = "*",
	cmd = "ToggleTerm",
	keys = {
		{ "<C-t>", desc = "Open / Close floating terminal" },
	},
	config = function()
		local toggleterm = require("toggleterm")

		local opts = {
			size = 20,
			on_close = function()
				vim.cmd("checktime")
			end,
			open_mapping = [[<C-t>]],
			hide_number = true,
			direction = "float",
			close_on_exit = true,
			insert_mappings = true,
			terminal_mappings = true,
		}

		toggleterm.setup(opts)

		vim.keymap.set("v", "<C-t>", ":ToggleTerm<CR>", { desc = "Open / Close floating terminal" })
	end,
}
