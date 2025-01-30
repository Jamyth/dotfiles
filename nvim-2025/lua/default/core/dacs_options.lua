-- This should only applies when under dacs environment
local dacs = os.getenv("DACS")
local opt = vim.opt

if dacs ~= nil then
	opt.tabstop = 2
	opt.softtabstop = 2
	opt.shiftwidth = 2
end
