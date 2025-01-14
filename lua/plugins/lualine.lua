return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				-- theme = "modus-vivendi",
				theme = "moonfly",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				always_show_tabline = true,
			},
			sections = {
				lualine_a = {
					{
						"mode",
						draw_empty = false,
						use_mode_colors = true,
					},
				},
				lualine_c = {
					"filename",
					"os.date('%X | %x')",
					"data",
					-- "require'lsp-status'.status()",
				},
			},
		})
	end,
}
