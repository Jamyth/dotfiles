local disable_lsp_formatters = { 'typescript-tools', 'jsonls' }
--- @return string?
local has_prettier_config = function()
    return vim.fs.root(0, {
        ".prettierrc",
        ".prettierrc.json",
        ".prettierrc.yaml",
        ".prettierrc.yml",
        ".prettierrc.json5",
        ".prettierrc.js",
        ".prettierrc.cjs",
        "prettier.config.js",
        "prettier.config.cjs",
        ".prettierrc.toml",
    })
end

--- @return string?
local has_eslint_config = function()
    return vim.fs.root(0, {
        ".eslinrc.js",
        ".eslinrc.cjs",
        ".eslinrc.yaml",
        ".eslinrc.json",
        "eslint.config.js",
        "eslint.config.mjs",
        "eslint.config.cjs",
        "eslint.config.ts",
        "eslint.config.mts",
        "eslint.config.cts",
    })
end

local get_formatters_for_js = function()
    --- @type conform.FiletypeFormatterInternal
    local formatters = {}

    if has_eslint_config() then
        formatters.lsp_format = "last"
    end

    if has_prettier_config() then
        table.insert(formatters, 'prettierd')
    end

    return formatters
end

return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
        local conform = require("conform")

        conform.setup({
            log_level = vim.log.levels.DEBUG,
            formatters_by_ft = {
                javascript = get_formatters_for_js,
                lua = { "stylua" },
            },
            format_on_save = {
                timeout_ms = 1000,
                --- @param client vim.lsp.Client
                filter = function(client)
                    return not vim.tbl_contains(disable_lsp_formatters, client.name)
                end,
                --- @see https://www.reddit.com/r/neovim/comments/1d3iodk/eslint_and_conform/
            },
        })
    end,
}
