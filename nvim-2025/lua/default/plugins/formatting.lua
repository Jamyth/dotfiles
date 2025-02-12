return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettierd", stop_after_first = true },
				typescript = { "prettierd", stop_after_first = true },
				javascriptreact = { "prettierd", stop_after_first = true },
				typescriptreact = { "prettierd", stop_after_first = true },
				svelte = { "prettierd", stop_after_first = true },
				html = { "prettierd", stop_after_first = true },
				css = { "prettierd", stop_after_first = true },
				json = { "prettierd", stop_after_first = true },
				yaml = { "prettierd", stop_after_first = true },
				markdown = { "prettierd", stop_after_first = true },
				graphql = { "prettierd", stop_after_first = true },
				lua = { "stylua" },
			},
			format_on_save = {
				async = false,
				timeout_ms = 700,
				lsp_format = "last",
				filter = function(client)
					return client.name == "eslint" -- Make sure only eslint lsp can do the formatting
				end,
				--@see https://www.reddit.com/r/neovim/comments/1d3iodk/eslint_and_conform/
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 700,
			})
		end, { desc = "Format file or range in insert / visual mode" })
	end,
}
