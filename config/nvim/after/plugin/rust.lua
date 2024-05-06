-- find local buffer
local bufnr = vim.api.nvim_get_current_buf()

-- FileType specific keymaps
vim.api.nvim_create_autocmd("FileType", {
	pattern = {"rust", "rs", "Rust"},
	callback = function ()
		vim.schedule(function ()
			vim.keymap.set("n", "<leader>rr", ":RustRun<CR>", {buffer = true})
			--rustaceanvim remaps
				--code actions
					vim.keymap.set("n", "<leader>ca", function ()
						vim.cmd.RustLsp('codeAction')
					end, {silent = true, buffer = bufnr})
				-- hover actions
					vim.keymap.set("n", "<leader>K", function ()
						vim.cmd.RustLsp { 'hover', 'actions' }
					end, {silent = true, buffer = bufnr})
				--explain error
					vim.keymap.set("n", "<leader>e", function ()
						vim.cmd('explainError')
					end, {silent = true, buffer = bufnr})
		end)
	end
})

--for debugging

local dap = require('dap')
dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = {"-i", "dap"}
}

dap.configurations.rust = {
	{
		name = "Launch",
		type = "gdb", 
		request = "launch",
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = "${workspaceFolder}",
		stopAtBegginingOfMainSubProgram = false,
	}
}
