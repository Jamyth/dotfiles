local get_file_path = function()
    local filename = vim.fn.expand("%:p")
    if filename == "" then
	return "😴 no file"
	end
	local cwd = vim.loop.cwd()
	if cwd then
		return string.sub(filename, cwd:len() + 1)
	else
		return filename
	end

end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
        local lualine = require("lualine")
        local lazy_status = require('lazy.status')
    end
}
