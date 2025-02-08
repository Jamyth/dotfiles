require("playground.main")
require("core.lazy_nvim").setup({
	{ import = "playground.plugins" },
	{ import = "playground.plugins.basic" },
	{ import = "playground.plugins.basic.ui" },
})
