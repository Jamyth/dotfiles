return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local nvim_tree_utils = require("playground.plugins.nvim-tree.utils")
        local nvim_tree_api = require("nvim-tree.api")
        local keymap = vim.keymap

        -- disable netrw at the very start
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- Enable 24-bit color
        vim.opt.termguicolors = true

        require('nvim-tree').setup({
            view = {
                side = "right",
                number = true,
                relativenumber = true,
            },
            renderer = {
                add_trailing = true, -- Show ending "/" to folder names
                root_folder_label = nvim_tree_utils.label_path,
                highlight_git = "icon", -- requires nvim-tree.git.enable to be true
                highlight_diagnostics = "name", -- require nvim-tree.diagnostics.enable to be true
                highlight_modified = "icon", -- require nvim-tree.modified.enabled
                
                indent_markers = {
                    enable = true
                }
            },
            git = {
                enable = true
            },
            modified = {
                enable = true
            },
            filesystem_watchers = {
                ignore_dirs = {
                    "node_modules",
                }
            },
            actions = {
                open_file = {
                    quit_on_open = true, -- Closes the tree when opening a file
                    window_picker = {
                        -- enable = false, -- A picker will show if opening a file which selectable pane
                    },
                }
            },
            update_focused_file = {
                enable = true, -- tree will update it self to center the opened file
            }
        })

        -- Configure Keymaps
        keymap.set("n", "<leader>ee", nvim_tree_api.tree.toggle, { desc = "Toggle Nvim Tree" })
    end
}
