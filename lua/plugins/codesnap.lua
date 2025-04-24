return {
	{
		"mistricky/codesnap.nvim",
		build = "make build generator",
		lazy = false,
		opts = {
			save_path = "~/codesnaps",
			bg_theme = "grape",
			watermark = "",
		},
	},
}
