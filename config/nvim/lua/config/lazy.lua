local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- the leader key is used in many keymaps, 

local plugins = {
	"nvim-lua/plenary.nvim",
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
	{"nvim-telescope/telescope.nvim", tag = "0.1.1",
		requires = { {"nvim-lua/plenary.nvim"}}},
	{"ThePrimeagen/harpoon",branch = "harpoon2",
		dependencies = {"nvim-lua/plenary.nvim"}},
	"mbbill/undotree",
	"tpope/vim-fugitive",
	--lsp configuration
		{"neovim/nvim-lspconfig"},
		{"hrsh7th/cmp-nvim-lsp"}, --autocompletion
		{"hrsh7th/nvim-cmp"}, --additional autocompletion
		{"L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp",
			dependencies = {'saadparwaiz1/cmp_luasnip', 
				'rafamadriz/friendly-snippets'}}, --snippet engine
		{"williamboman/mason.nvim"}, --lsp manager
		{"williamboman/mason-lspconfig.nvim"}, --lsp configs manager
	--colorscheme
	{"Tsuzat/NeoSolarized.nvim",lazy = false, priority=1000},
	-- for Rust
	{'mrcjkb/rustaceanvim', version = '^4', lazy = false},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
	},
	{'mfussenegger/nvim-dap'},
}

require("lazy").setup(plugins, {})
