return {
	"windwp/nvim-autopairs",
	event = { "TextChanged", "TextChangedI", "InsertEnter" },
	dependencies = { "hrsh7th/nvim-cmp" },
	config = function()
		local autopairs = require("nvim-autopairs")

		autopairs.setup({
			check_ts = true, -- enable treesitter
			ts_config = {
				lua = { "string" },
				javascript = { "template_string" }, -- don't add pairs in javascript template_string treesiter nodes
				-- java = false, -- don't check treesitter on java
			},
		})

		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")

		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
