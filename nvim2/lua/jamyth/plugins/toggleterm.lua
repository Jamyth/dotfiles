return {
	"akinsho/toggleterm.nvim",
	version = "*",
	keys = {
		{ "<C-t>", desc = "Open floating terminal" },
	},
	opts = {
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
	},
}
