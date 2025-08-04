return {
	{

		"norcalli/nvim-colorizer.lua",
		ft = { "css" },
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"folke/trouble.nvim",
		-- dependencies = {"echasnovski/mini.icons"} maybe later
		lazy = false,
		opts = {},
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
		dependencies = { "tpope/vim-fugitive" },
		lazy = false,
	},
	{
		"jiaoshijie/undotree",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
		keys = { -- load the plugin only when using it's keybinding:
			{ "<leader>u", "<cmd>lua require('undotree').toggle()<cr>", { desc = "Toggle Undotree" } },
		},
	},
	{
		"ThePrimeagen/harpoon",
		VeryLazy = true,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins.config.harpoon")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			pcall(require("telescope").load_extension, "ui-select")
			pcall(require("telescope").load_extension("remote-sshfs"))
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		-- dependencies = { "dhawton/vsc-fivem", "JericoFX/QBCore-FX-Snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{ "sharkdp/fd" },
	{ "BurntSushi/ripgrep" },
	{
		"xiyaowong/transparent.nvim",
		opts = {
			extra_groups = {
				"TreesitterContext",
				"LineNr",
			},
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			fast_warp = {},
			disable_filetype = { "TelescopePrompt", "vim" },
		},
		config = function(_, opts)
			require("nvim-autopairs").setup(opts)

			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		--dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
		opts = {},
		lazy = false,
	},
	{
		"luckasRanarison/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {},
	},
	{
		"nosduco/remote-sshfs.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		opts = {},
	},
}
