return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function ()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            -- Core Setup
            ensure_installed = { "c", "lua", "vim", "vimdoc" },
            sync_install = false,
            auto_install = true,
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
            }

            -- Other Plugin Integrations
        })
    end
}
