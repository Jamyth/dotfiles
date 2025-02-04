vim.g.mapleader = " "

local keymap = vim.keymap

-- Shortcuts
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "J", "mzJ`z", { desc = "Take the line below and append to current lint with moving cursor" })

-- Line mover
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move current line upward" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move current line downward" })

-- Search related
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highligh" })
keymap.set("n", "n", "nzzzv", { desc = "To next search then center the cursor" })
keymap.set("n", "N", "Nzzzv", { desc = "To previous search then center the cursor" })

-- Number In/Decrement
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Window managements
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make window equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Less use but good to have
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close new tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- Make sense keymap
keymap.set("n", "U", "<C-R>", { desc = "u is undo, U should be redo" })

-- Navigation related
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Navigate half page down then center the cursor" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Navigate half page up then center the cursor" })

-- Tmux related
keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
