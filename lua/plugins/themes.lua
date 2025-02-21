return {
	{ "rose-pine/neovim", lazy = false },
	{ "sainnhe/gruvbox-material", lazy = false },
	{ "tomasr/molokai", lazy = false },
	{ "sainnhe/everforest", lazy = false },
	{
		"miikanissi/modus-themes.nvim",
		lazy = false,
		config = function()
			require("modus-themes").setup({
				transparent = true,
				variant = "deuteranopia",
				line_nr_column_background = false,
				sign_column_background = false,
			})
		end,
	},
}
