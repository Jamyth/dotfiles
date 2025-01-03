-- vim.g.max_opened_buffers = 20

-- local function manage_buffer_queue()
-- 	local buffers = vim.fn.getbufinfo({ buflisted = 1 })
-- 	if #buffers > vim.g.max_opened_buffers then
-- 		vim.cmd("bd " .. buffers[1].bufnr)
-- 	end
-- end
--
-- vim.api.nvim_create_autocmd("BufEnter", { callback = manage_buffer_queue })
