return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	config = function()
		local which_key = require("which-key")

		local mapping = {
			{
				mode = { "n", "v" },
				{ "<leader>e", group = "Neo-tree" },
				{ "<leader>f", group = "Telescope" },
				{ "<leader>h", group = "Gitsigns" },
				{ "<leader>w", group = "Workspace Session" },
				{ "<leader>s", group = "Window Management" },
				{ "<leader>t", group = "Tab Management" },
			},
		}

		which_key.setup()

		which_key.add(mapping)
	end,
}
