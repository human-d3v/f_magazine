vim.api.nvim_create_autocmd("FileType", {
	pattern = {'typescript','javascript','js','ts'},
	callback = function ()
		vim.schedule(function ()
			vim.keymap.set('n', '<leader><leader>t', 
				[[:lua OpenTerminalBuffer()<CR>]], {buffer = true, silent = true})
			vim.keymap.set('i', '>', '=>', {buffer = true, silent = true})
			vim.keymap.set('i', '>>', '>', {buffer = true, silent = true})
		end)
	end,
})
