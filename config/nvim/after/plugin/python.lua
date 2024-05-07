function OpenTerminalBuffer(opt)
	vim.api.nvim_exec2('belowright split | term', {output = true})
	local bufnr = vim.api.nvim_get_current_buf()
	vim.api.nvim_chan_send(vim.api.nvim_get_option_value('channel', {buf = bufnr}), opt .. '\r')
end

local function nextLine()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local total_lines = vim.api.nvim_buf_line_count(0)

	for i = current_line + 1, total_lines do
		local line_content = vim.api.nvim_buf_get_lines(0, i-1, i, false)[1]
		if line_content:match('^%S') then
			vim.api.nvim_win_set_cursor(0, {i, 0})
			break
		end
	end
end


function SendToRepl(opt)
	-- 0: send current line to buffer
	-- 1: send visual selection to buffer
	-- 2: send entire file to up and including the current line to buffer
	local txt = ''
	if opt == 1 then
		vim.cmd('normal! gv"xy')
		txt = vim.fn.getreg('x')
	elseif opt == 2 then
		local ln, _ = unpack(vim.api.nvim_win_get_cursor(0))
		local lineTxts = vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(),
			0, ln, false)
		txt = table.concat(lineTxts, '\n')
	else
		txt = vim.api.nvim_get_current_line()
	end

	nextLine()

	local term_buf = nil
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[bufnr].buftype == 'terminal' then
			term_buf = bufnr
			break
		end
	end
	if term_buf == nil then
		print('No terminal buffer found')
		return 
	end

	vim.api.nvim_chan_send(vim.api.nvim_get_option_value('channel',{buf = term_buf}), txt .. '\r')
end

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'python',
	callback = function()
		vim.schedule(function ()
			vim.keymap.set('n', '<leader><leazder>py', [[:lua OpenTerminalBuffer('python3')]])
			vim.keymap.set({'v','x'}, "<BSlash>d", [[:lua SendToRepl(1)]])
			vim.keymap.set('n', "<BSlash>d", [[:lua SendToRepl(0)]])
			vim.keymap.set('n', "<BSlash>aa", [[:lua SendToRepl(2)]])
		end)
	end,
})
