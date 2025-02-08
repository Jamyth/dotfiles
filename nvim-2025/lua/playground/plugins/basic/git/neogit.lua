return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim"
    },
    config = function()
        local neogit = require("neogit")
        local keymap = vim.keymap

        neogit.setup()

        -- keymaps
        keymap.set("n", "<leader>lg", function() neogit.open({ kind = "floating" }) end, { desc = "Open Neogit" })
        keymap.set("n", "<leader>hd", function() neogit.open({ "diff" }) end, { desc = "Open Neogit Diffview" })
    end
}
