return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	keys = { "<leader>", "<c-r>", '"', "'", "`", "c", "v", "g" },
	--	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local wk = require("which-key")
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")
		-- template:
		-- {"", "", desc=""}
		wk.add({
			{
				mode = { "n" },

				-- {
				-- 	"<C-n>",
				-- 	"<cmd> NvimTreeToggle<CR>",
				-- 	desc = "Toggle Tree",
				-- },
				{
					"<C-n>",
					"<cmd> Ex<CR>",
					desc = "Ex",
				},

				{ "<leader>l", group = "LSP" },
				{
					"<leader>li",
					"<cmd> lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) <CR>",
					desc = "Toggle Inlay hints",
				},

				{ "<leader>p", group = "Project" },
				{
					"<leader>pf",
					"<cmd> Telescope find_files <CR>",
					desc = "Find Files",
				},
				{
					"<leader>ps",
					"<cmd> Telescope live_grep <CR>",
					desc = "Live Grep",
				},
				{
					"<leader>pd",
					require("telescope.builtin").diagnostics,
					desc = "Search Diagnostics",
				},

				{
					"<leader>a",
					mark.add_file,
					desc = "Harpoon file",
				},
				{ "<leader>q", group = "Harpoon" },
				{
					"<leader>qm",
					ui.toggle_quick_menu,
					desc = "Toggle Quick Menu",
				},

				{ "<leader>d", group = "Dapui" },
				{
					"<leader>db",
					"<cmd> DapToggleBreakpoint <CR>",
					desc = "Toggle Breakpoint",
				},

				{
					"<leader>y",
					'"+y',
					desc = "Copy to clipboard",
				},
				{
					"<leader>d",
					'"_d',
					desc = "Delete Forever",
				},

				{
					"<leader>td",
					"<cmd>Trouble diagnostics<CR>",
					desc = "Trouble Diagnostics",
				},
				{
					"<leader>/",
					function()
						require("Comment.api").toggle.linewise.current()
					end,
					desc = "Toggle Comment",
				},
				{
					"<leader>dr",
					"<cmd>lua if vim.bo.filetype == 'rust' then vim.cmd.RustLsp('debuggables') else require'dap'.continue() end<CR>",
					desc = "Start or Continue Debugger",
				},

				-- fugitive
				{
					"<leader>dv",
					"<cmd>Gvdiffsplit!<CR>",
					desc = "Fugitive diffsplit",
				},
				{
					"gf",
					"<cmd>diffget //2<CR>",
					desc = "Fugitive the left side",
				},
				{
					"gj",
					"<cmd>diffget //3<CR>",
					desc = "Fugitive the right side",
				},
			},
			{
				mode = { "v" },
				{
					"<leader>y",
					'"+y',
					desc = "Copy to clipboard",
				},
				{
					"<leader>dd",
					'"_d',
					desc = "Delete Forever",
				},
				{
					"<leader>/",
					'<ESC><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>',
					desc = "Toggle Comment",
				},
				{ "<leader>p", '"_dP', desc = "Replace without copy" },
			},
		})
	end,
}
