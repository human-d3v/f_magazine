require("mason").setup({})
require("mason-lspconfig").setup({
    handlers = {
        function(server_name)
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            require("lspconfig")[server_name].setup({
                capabilities = capabilities
            })
        end,
    },
})

--specific for lsp support for neovim configuration
--shoutout to @VonHeikemen
--local function nvim_workspace(opts)
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')
require('lspconfig').lua_ls.setup({
		settings = {
			Lua = {
				--Disable telemetry
				telemtry = {enable = false},
				runtime = {
					--tell lsp which version of lua you're using 
					version = 'LuaJIT',
					path = runtime_path,
				},
				diagnostics = {
					globals = { 'vim'}
				},
				workspace = {
					checkThirdParty = false,
				library = {
					--make server aware of nvim runtime files
					vim.fn.expand('$VIMRUNTIME/lua'),
					vim.fn.stdpath('config') .. '/lua'
				}
			}
		}
	}
})
