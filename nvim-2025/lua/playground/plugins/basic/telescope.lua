return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- use native fzf algo instead of builtin lua-based algo
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        "<leader>ff",
        "<leader>fs",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local builtin = require("telescope.builtin")
        local keymap = vim.keymap

        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-c>"] = actions.close,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    },
                    n = {
                        ["q"] = actions.close,
                        ["<C-c>"] = actions.close,
                    },
                },
            },
            extensions = {
                -- These are the default options, just to explicitly present here
                fzf = {
                    fuzzy = true,    -- Enable Fuzzy searching
                    override_generic_sorter = true, -- Overrides the default sorter
                    override_file_sorter = true, -- Override file sorter
                    case_mode = "smart_case",
                },
            },
        })

        -- Load the native fzf
        telescope.load_extension("fzf")

        keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
        keymap.set("n", "<leader>fs", function()
            builtin.grep_string({search = vim.fn.input("Grep > ") })
        end, { desc = "Telescope Search by word" })
        keymap.set("n", "<leader>ft", builtin.diagnostics, { desc = "Telescope Diagnostics" })

        -- Git integration
        keymap.set("n", "<leader>hs", builtin.git_status, { desc = "Telescope git files" })
    end,
}
