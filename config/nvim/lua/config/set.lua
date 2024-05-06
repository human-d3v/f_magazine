-- line numbering
vim.opt.nu = true
vim.opt.relativenumber = true


-- tab spaces
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.expandtab = 2

-- good colorings
vim.opt.termguicolors = true

vim.g.rustaceanvim = {
	tools = {
	},
	server = {
		cmd = function()
			local mason_registry = require('mason-registry')
			local ra_binary = mason_registry.is_installed('rust-analyzer')
				and mason_registry.get_package('rust-analyzer'):get_install_path() .. "/rust-analyzer"
				or "rust-analyzer"
			return {ra_binary}
		end,
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
