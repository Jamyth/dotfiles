return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"folke/neodev.nvim", -- vim api support in lua_ls
	},
	config = function()
		local neodev = require("neodev")
		local lspconfig = require("lspconfig")
		-- Since this plugin is lazy-loaded
		-- mason-lspconfig should be installed
		-- TODO:Jamyth - use pcall instead
		local mason_lspconfig = require("mason-lspconfig")
		local telescope_builtin = require("telescope.builtin")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap

		-- Configure UI related
		vim.diagnostic.config({
			virtual_text = true,
			serverity_sort = true,
			signs = {
				active = {
					{ name = "DiagnosticSignError", text = "" },
					{ name = "DiagnosticSignWarn", text = "" },
					{ name = "DiagnosticSignHint", text = "" },
					{ name = "DiagnosticSignInfo", text = "" },
				},
			},
			-- float = {
			--     source = true,
			--     border = "rounded",
			-- }
		})
		-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		--     border = "rounded",
		--     width = 60,
		-- })
		local signs = {
			Error = " ",
			Warn = " ",
			Hint = " ",
			Info = " ",
		}
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- Handlers
		local on_attach = function(client, bufnr)
			-- Keybindings for lsp features
			local opts = { noremap = true, buffer = bufnr, silent = true }

			opts.desc = "Show LSP references"
			keymap.set("n", "gr", telescope_builtin.lsp_references, opts)

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", telescope_builtin.lsp_definitions, opts)

			opts.desc = "Show LSP Implementations"
			keymap.set("n", "gi", telescope_builtin.lsp_implementations, opts)

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", telescope_builtin.lsp_type_definitions, opts)

			opts.desc = "See available code actions"
			keymap.set("n", "<leader>lc", vim.lsp.buf.code_action, opts)

			opts.desc = "Rename symbol"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", function()
				telescope_builtin.diagnostics({ bufnr = bufnr })
			end, opts)

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "<leader>dN", vim.diagnostic.goto_prev, opts)

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, opts)

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts)

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
		end

		-- Autocomplete
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Automatically setup language-servers
		mason_lspconfig.setup_handlers({
			function(server_name)
				if server_name == "lua_ls" then
					neodev.setup()
				end
				lspconfig[server_name].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["eslint"] = function()
				lspconfig.eslint.setup({
					capabilities = capabilities,
					on_attach = function(client, bufnr)
						on_attach(client, bufnr)
						-- Disable ESLint's formatting capability to avoid conflicts with conform.nvim
						client.server_capabilities.documentFormattingProvider = false

						-- Formatting
						-- TODO:Jamyth double check the autocmd orders with conform.nvim
						-- Autofixes should run after the conform formatting
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.code_action({
									context = { only = { "source.fixAll" }, diagnostics = {} },
									apply = true,
								})
							end,
						})
					end,
					settings = {
						format = { enable = true },
					},
					cmd = { "eslint_d", "--stdio" },
				})
			end,
		})
	end,
}
