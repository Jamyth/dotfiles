return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim", -- add here as dependency
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")

        mason.setup()
        mason_lspconfig.setup()

        -- Automatically setup language-servers
        -- mason_lspconfig.setup_handlers({
        --     function(server_name)
        --
        --     end
        -- })
    end
}
