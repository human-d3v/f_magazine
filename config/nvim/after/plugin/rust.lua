local bufnr = vim.api.nvim_get_current_buf()
--code actions
vim.keymap.set("n", "<leader>ca", function ()
	vim.cmd.RustLsp('codeAction')
	end,
	{silent = true, buffer = bufnr})
--hover actions
vim.keymap.set("n", "<leader>K", function ()
	vim.cmd.RustLsp { 'action', 'hover' }
end,
	{silent = true, buffer = bufnr})

-- FileType specific keymaps
vim.api.nvim_create_autocmd("FileType", {
	pattern = {"rust", "rs", "Rust"},
	callback = function ()
		vim.schedule(function ()
			vim.keymap.set("i", ">", "=>", {buffer = true})
			vim.keymap.set("i", ">>", ">", {buffer = true})
			vim.keymap.set("n", "<leader>rr", ":RustRun<CR>", {buffer = true})
		end)
	end
})

-- fix lsp support
vim.g.rustaceanvim = {
	tools = {
	},
	server = {
		on_attach = function (client, bufnr)
		end,
		default_settings = {
			['rust-analyzer'] = {
			},
		},
  },
	dap = {
	},
}
