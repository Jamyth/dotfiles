return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		local eslint_fix_lint_augroup = vim.api.nvim_create_augroup("eslint_fix_lint", { clear = true })

		local function has_eslint_config()
			local eslint_files = { ".eslintrc", ".eslintrc.js", ".eslintrc.json", ".eslintrc.yaml", "eslintrc.yml" }
			for _, file in ipairs(eslint_files) do
				if vim.fn.glob(file) ~= "" then
					return true
				end
			end
			return false
		end

		local function is_auto_fixable()
			local current_filetype = vim.bo.filetype
			local available_filetype = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
			for _, filetype in ipairs(available_filetype) do
				if current_filetype == filetype then
					return true
				end
			end
			return false
		end

		vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			group = eslint_fix_lint_augroup,
			callback = function()
				if has_eslint_config() and is_auto_fixable() then
					vim.cmd("EslintFixAll")
				end
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
