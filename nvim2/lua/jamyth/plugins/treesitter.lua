return {
	"nvim-treesitter/nvim-treesitter", -- Syntax highlighting
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag", -- Use treesitter to auto close & auto rename html tags
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			auto_install = false,
			sync_install = true,
			highlight = {
				enable = true,
			},
			-- enable indentation
			indent = {
				enable = true,
				-- disable = { 'yaml' }
			},
			-- enable autotagging ( w/ nvim-ts-autotag plugin )
			autotag = { enable = true },
			-- ensure these language parsers are installed
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"javascript",
				"typescript",
				"json",
				"json5",
				"yaml",
				"css",
				"dockerfile",
				"bash",
				"tsx",
				"jsdoc",
				"html",
				"markdown",
				"markdown_inline",
				"xml",
			},
			incremental_selection = {
				-- TODO/Jamyth keymap conflict with keyboard lanuage switch
				enable = false,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})
	end,
}
