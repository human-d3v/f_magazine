local okay_status, NeoSolarized = pcall(require, "NeoSolarized")
if not okay_status then
  return
end

NeoSolarized.setup({
	style="dark",
	transparent=true,
	terminal_colors=true,
	enable_italics=true,
	syles = {
		comment = { italic = true },
		keyword = { italic = true },
		functions = { bold = true },
		variables = {},
		string = {italic = true},
		underline=true,
		undercurl=true,
	},
	on_highlights = function (highlights, colors)
		-- if you leave the visual defaults, visual highlights are invisible
		highlights.Visual = {
			bg = '#eee8d5',
			fg = '#839496'
		}
	end,
 })

local function bg_opacity()
	local clr = "NeoSolarized"
	vim.cmd.colorscheme(clr)
	vim.opt.background = "dark"
	vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
	vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
end



bg_opacity()
