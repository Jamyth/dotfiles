vim.g.netrw_liststyle = 3

local opt = vim.opt

opt.guicursor = "" -- make sure the cursor matches in normal & insert mode

opt.relativenumber = true -- show relative line number
opt.number = true -- show current line-number

-- tabs & indentation
opt.tabstop = 4 -- 4 spaces for tab (prettier default)
opt.shiftwidth = 4 -- 4 space for indent with
opt.softtabstop = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.smarttab = true

opt.spell = true -- spell checker

opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- theme
opt.termguicolors = true
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true
opt.splitbelow = true

-- Scrolling
opt.scrolloff = 20

-- Unknown options (need to figure)
opt.isfname:append("@-@")
opt.colorcolumn = "180"

opt.updatetime = 150 -- Screen refresh time
