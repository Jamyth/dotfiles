vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.guicursor = "" -- make sure cursor matches in normal & insert mode

opt.relativenumber = true -- show relative line number
opt.number = true -- show current line-number

-- tabs & indentation
opt.tabstop = 4 -- 4 spaces for tab (prettier default)
opt.shiftwidth = 4 -- 4 spaces for indent width
opt.softtabstop = 4
opt.expandtab = true -- expand tab to space
opt.autoindent = true -- Copy indent from current line when starting new one
opt.smartindent = true
opt.smarttab = true

-- spell checker
opt.spell = true

opt.wrap = false

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if search includes mixed-case, assuming Case-Sensitive

-- theme
opt.termguicolors = true
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line, or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true
opt.splitbelow = true

-- Scrolling
opt.scrolloff = 16

-- Unknown options (need to figure)
opt.isfname:append("@-@")
opt.colorcolumn = "180"

opt.updatetime = 150 -- Screen refresh time
