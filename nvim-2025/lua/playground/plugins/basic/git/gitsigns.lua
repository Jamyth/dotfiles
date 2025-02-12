return {
	"lewis6991/gitsigns.nvim",
	event = { "BufRead", "BufNewFile" },
	config = function()
		local gitsigns = require("gitsigns")

		local on_attach = function(bufnr)
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
			end, { desc = "gitsigns - navigate next hunk" })

			map_key("n", "<leader>hN", function()
				if vim.wo.diff then
					print("no git changes")
				else
					gitsigns.nav_hunk("prev")
				end
			end, { desc = "gitsigns - navigate previous hunk" })

			map_key("n", "<leader>hs", gitsigns.stage_hunk, { desc = "gitsigns - stage/unstage hunk" })
			map_key("n", "<leader>hr", gitsigns.reset_hunk, { desc = "gitsigns - reset hunk" })

			-- Un/Stage by line
			map_key("v", "<leader>hs", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "gitsigns - stage/unstage line" })

			map_key("v", "<leader>hr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "gitsigns - reset line" })

			map_key("n", "<leader>hS", gitsigns.stage_buffer, { desc = "stage/unstage buffer" })
			map_key("n", "<leader>hR", gitsigns.reset_buffer, { desc = "reset buffer" })
			map_key("n", "<leader>hp", gitsigns.preview_hunk, { desc = "preview hunk" })
			map_key("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "preview hunk inline" })

			-- Text object
			map_key({ "o", "x" }, "ih", "<cmd>Gitsigns select_hunk<CR>", { desc = "textobject - hunk" })
		end

		gitsigns.setup({
			on_attach = on_attach,
			current_line_blame = true,
		})
	end,
}
