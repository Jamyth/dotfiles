return {
    "lewis6991/gitsigns.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function ()
        local gitsigns = require("gitsigns")
        local keymap = vim.keymap

        local on_attach = function (bufnr)
            local map_key = function(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map_key("n", "<leader>hn", function() 
                if vim.wo.diff then
                    print("no git changes")
                else
                    gitsigns.nav_hunk("next")
                end
            end)

            map_key("n", "<leader>hN", function() 
                if vim.wo.diff then
                    print("no git changes")
                else
                    gitsigns.nav_hunk("prev")
                end
            end)

            map_key("n", "<leader>hs", gitsigns.stage_hunk)
            map_key("n", "<leader>hr", gitsigns.reset_hunk)
            
            -- Un/Stage by line
            map_key('v', '<leader>hs', function()
                gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
            end)

            map_key('v', '<leader>hr', function()
                gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
            end)

            map_key('n', '<leader>hS', gitsigns.stage_buffer)
            map_key('n', '<leader>hR', gitsigns.reset_buffer)
            map_key('n', '<leader>hp', gitsigns.preview_hunk)
            map_key('n', '<leader>hi', gitsigns.preview_hunk_inline)

            -- Text object
            map_key({'o', 'x'}, 'ih', '<cmd>Gitsigns select_hunk<CR>')
        end

        gitsigns.setup({
            on_attach = on_attach,
            current_line_blame = true
        })

    end
}
