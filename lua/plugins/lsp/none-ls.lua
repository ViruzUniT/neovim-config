return {
	"nvimtools/none-ls.nvim",
	event = "VeryLazy",
	setup = function()
		return require("core.configs.null-ls")
	end,
}
