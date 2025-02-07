return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context", -- show the context of the code block
        "nvim-treesitter/nvim-treesitter-textobjects", -- add syntax-aware text-objects
    },
    config = function ()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            -- Core Setup
            ensure_installed = { "c", "lua", "vim", "vimdoc", "regex" },
            sync_install = false,
            -- Do not install missing parser when entering
            auto_install = false,
            highlight = {
                enable = true,

                -- Disable syntax highlighting if file is too large
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stats, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                    return false
                    
                end,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },

            -- Other Plugin Integrations
            -- text objects
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["ar"] = "@regex.outer",
                        ["ir"] = "@regex.inner",
                        ["ab"] = "@block.outer",
                        ["ib"] = "@block.inner",
                    }
                }
            }
        })
    end
}
