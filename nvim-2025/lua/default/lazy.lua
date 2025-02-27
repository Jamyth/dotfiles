-- Lazy.nvim bootstrap code
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Setup Lazy.nvim
require("lazy").setup({
	{ import = "default.plugins" },
	{ import = "default.plugins.lsp" },
}, {
	checker = { -- show updatable package in lualine instead of notifying
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})
